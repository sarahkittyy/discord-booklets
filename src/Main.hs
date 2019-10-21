module Main where
    
import Discord
import Discord.Types
import System.IO (readFile)
import Data.Text (unpack, pack, Text)

import Dispatch

-- | Reads the token from the .token file.
getToken :: IO String
getToken = (return . head . lines) =<< readFile ".token"

-- | Reads in a token,, and runs the discord bot.
bot :: String -> IO ()
bot token = do
    res <- runDiscord $ def { discordToken = pack token
                            , discordOnEvent = dispatch }
    putStrLn $ unpack res
    return ()
    
-- | Starts the bot-- entry point.
main :: IO ()
main = putStrLn "Starting..." >> getToken >>= bot