{-# LANGUAGE DeriveGeneric #-}

-- | Module for reading books from the json file.
module Books
( Book
, Library
, getLibrary
, getBook
) where

import Data.Map
import Prelude hiding (lookup, readFile)
import Data.Aeson
import GHC.Generics
import Data.ByteString.Lazy (readFile)

-- | A book is consisted of pages
type Book = [String]
-- | A library is a collection of books to their titles
data Library = Library { books :: Map String Book } deriving (Generic, Show)

instance ToJSON Library where
    toEncoding = genericToEncoding defaultOptions
instance FromJSON Library where
    
-- | Returns the library of books
getLibrary :: IO Library
getLibrary = do
    contents <- readFile "books.json"
    case decode contents of
        Nothing -> error $ "Invalid books format."
        Just res -> return res

-- | Tries to get a book from the given library
getBook :: String -> Library -> Maybe Book
getBook input = lookup input . books