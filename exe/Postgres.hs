{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TypeFamilies               #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE EmptyDataDecls #-}

import Control.Monad.IO.Class (liftIO)
import Control.Monad.Logger (runStdoutLoggingT)
import Data.ByteString (ByteString)
import Data.Semigroup ((<>))
import Data.Text (Text, pack)
import Data.Text.Encoding (encodeUtf8)
import Database.Persist (Entity(..), Entity)
import Database.Persist.Postgresql ( ConnectionString
                                   , parseMigration
                                   , printMigration
                                   , runMigration
                                   , runMigrationUnsafe
                                   , withPostgresqlPool)
import Database.Persist.Sql (runSqlPersistMPool)
import qualified Database.Persist.TH as PTH
import Options.Applicative

-- Ref:
-- - https://mmhaskell.com/blog/2017/10/2/trouble-with-databases-persevere-with-persistent

-- data User = User
--   { userName :: Text
--   , userEmail :: Text
--   , userAge :: Int
--   , userOccupation :: Text
--   }

PTH.share [PTH.mkPersist PTH.sqlSettings, PTH.mkMigrate "migrateAll"] [PTH.persistLowerCase|
  User sql=users
    name Text
    age Int
    occupation Text
    deriving Show Read
|]

-- sampleUser :: Entity User
-- sampleUser = Entity (toSqlKey 1) $ User
--   { userName = "admin"
--   , userEmail = "admin@test.com"
--   , userAge = 23
--   , userOccupation = "System Administrator"
--   }

-- https://www.postgresql.org/docs/current/static/libpq-connect.html#LIBPQ-CONNSTRING
newtype Options = Options { pgConnStr :: Text }
parser :: Parser Options
parser = Options
      <$> argument str
          ( metavar "CONNSTRING"
         <> help "connection string for postgres database" )

main :: IO ()
main = do
  Options {..} <- execParser opts
  runStdoutLoggingT $ withPostgresqlPool (encodeUtf8 pgConnStr) 10 $ \pool ->
    liftIO $ flip runSqlPersistMPool pool $ do
      runMigrationUnsafe migrateAll
  where
    opts = info ( parser <**> helper)
      ( fullDesc
     <> progDesc "Illustration of persistent + PostgreSQL"
      )
