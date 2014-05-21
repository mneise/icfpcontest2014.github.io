--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll

--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "templates/*" $ compile templateCompiler

    match "stylesheets/*" $ do
        route   idRoute
        compile compressCssCompiler

    match (fromList ["javascripts/*", "images/*"]) $ do
        route   idRoute
        compile copyFileCompiler

    match (fromList ["index.markdown"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

