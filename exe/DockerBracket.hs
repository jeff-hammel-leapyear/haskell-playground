{-# LANGUAGE OverloadedStrings #-}

-- | The bracket pattern with Docker

import Data.String (fromString)
import Data.Text (unpack)
import Docker.Client ( ContainerID
                     , HostPort(..)
                     , PortBinding(..)
                     , PortType(..)
                     , Timeout(..)
                     , addPortBinding
                     , createContainer
                     , defaultClientOpts
                     , defaultCreateOpts
                     , defaultStartOpts
                     , defaultHttpHandler
                     , runDockerT
                     , startContainer
                     , stopContainer
                     )
import Docker.Client.Types (fromContainerID)

-- For Mac:
-- docker run -d -v /var/run/docker.sock:/var/run/docker.sock -p 127.0.0.1:2375:2375 bobrik/socat TCP-LISTEN:2375,fork UNIX-CONNECT:/var/run/docker.sock
-- see https://github.com/docker/for-mac/issues/770


-- https://github.com/denibertovic/docker-hs/blob/master/examples/Example.hs#L25
runPostgresContainer :: IO ContainerID
runPostgresContainer = runContainer "postgres:9.6" [(5432, 5432)]

runContainer :: String -> [(Integer, Integer)] -> IO ContainerID
runContainer image portMapping = do
  h <- defaultHttpHandler
  runDockerT (defaultClientOpts, h) $
    do
       let myCreateOpts = foldl (\opts (host, guest) -> addPortBinding (PortBinding guest TCP [HostPort "0.0.0.0" host]) opts) (defaultCreateOpts $ fromString image) portMapping
       cid <- createContainer myCreateOpts Nothing
       case cid of
         Left err -> error $ show err
         Right i -> do
           _ <- startContainer defaultStartOpts i
           return i


stopContainer' :: ContainerID -> IO ()
stopContainer' cid = do
  h <- defaultHttpHandler
  runDockerT (defaultClientOpts, h) $ do
    r <- stopContainer DefaultTimeout cid
    case r of
      Left err -> error $ "Failed to stop the container" ++ (containerIDString cid)
      Right _ -> return ()

containerIDString :: ContainerID -> String
containerIDString = unpack . fromContainerID

main :: IO ()
main = do
  cid <- runPostgresContainer
  putStrLn $ containerIDString cid
  stopContainer' cid
