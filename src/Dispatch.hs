{-# LANGUAGE OverloadedStrings #-}
module Dispatch
( dispatch
) where
    
import Discord
import Discord.Types
import qualified Discord.Requests as R

import Util (isFromBot)
import Control.Monad (when)
import Data.Text (Text, pack, unpack)

import Commands
import Data.List (isPrefixOf)
import Data.List.Split

-- | Send an error to the user
sendError :: DiscordHandle -> Message -> String -> IO ()
sendError dis msg err = (\_ -> return ()) =<<
                            (restCall dis $ R.CreateMessage (messageChannel msg) $ pack err)

-- | Main discord event handler.
dispatch :: DiscordHandle -> Event -> IO ()
dispatch dis evt = do
    case evt of
        MessageCreate msg -> when (not (isFromBot msg)) $ do
            case parseCommand $ (unpack . messageText) msg of
                Just args -> (do
                    res <- runCommand dis msg args
                    case res of
                        Nothing -> return ()
                        Just err -> sendError dis msg err)
                _ -> return ()
        _ -> return ()
    return ()
    
-- | Checks if the message given is a command, and splits it into args if so.
parseCommand :: String -> Maybe [String]
parseCommand text = if isPrefixOf "!" text
                        then Just $ splitOn " " $ tail text
                        else Nothing