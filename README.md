# haskell-playground

Jeff's adventures in the land of lambda.

## Installation

In this directory:
```
stack install haskell-playground
```

## Testing

```
stack build haskell-playground:test:haskell-playground-spec
```

## Parsing XML

Everyone's favorite thing to do in any language.


I started out looking at the
[Haskell XML Toolbox (HXT)](http://hackage.haskell.org/package/hxt):
"The Haskell XML Toolbox bases on the ideas of HaXml and HXML,
but introduces a more general approach for processing XML with Haskell."
That all sounds great, and I did want to learn the
[Arrow approach](https://www.haskell.org/arrows/).

However, in practice, I have found HXT hard to learn:  people say it is
old (as a Haskell newbie, it is hard for me to assess what is old).
While there is a strong web presence for HXT ( e.g. https://wiki.haskell.org/HXT ,
http://hackage.haskell.org/package/hxt ,
http://hackage.haskell.org/package/hxt-filter ,
http://www.fh-wedel.de/~si/HXmlToolbox/index.html ,
https://github.com/UweSchmidt/hxt ) , the various forms of the documentation
versus packages do not seem in sync.  In particular, various tutorials
recommend and/or depend on `hxt-filter`, which when trying to depend on it
gives
```
In the dependencies for haskell-playground-0.1.0.0:
    hxt-filter must match -any, but the stack configuration has no specified
               version (latest matching version is 8.4.2)
needed since haskell-playground is a build target.
```
I've been told this is because `hxt-filter` is not in
[Stackage](https://www.stackage.org/).

[xml-conduit](https://hackage.haskell.org/package/xml-conduit)
is now what I will examine.  Does it do anything?
As a newbie, I couldn't really figure out if this library looked
right for me, and there also weren't many examples.

Now I'm looking at [xeno](https://github.com/ocramz/xeno).
It was
[written as an experiment](https://chrisdone.com/posts/fast-haskell-c-parsing-xml)
and doesn't expose many functions but it does have a nifty
[SAX Parser](http://hackage.haskell.org/package/xeno-0.3.3/docs/src/Xeno-SAX.html).

See also https://stackoverflow.com/questions/4619206/parse-xml-in-haskell
and https://stackoverflow.com/questions/1361307/which-haskell-xml-library-to-use .

Also to consider: http://hackage.haskell.org/package/sax


## Persisting data

The [persistent package](https://www.stackage.org/package/persistent)
is highly recommended as a great example of what Haskell and functional
programming can do. Having dealt with various SQls over the years,
while ORMs can be convenient (misued they may also make life
*extremely inconvenient*!), but OO does not seem a natural fit for
relational database queries.  Functions do.