-- | All defined commands the bot accepts.
module Commands
( runCommand
) where
    
import Discord
import Discord.Types
import qualified Discord.Requests as R

import Data.Map
import Prelude hiding (lookup)

-- | The type of a command handler
type CommandHandle = DiscordHandle -> Message -> [String] -> IO (Maybe String)
    
-- | The main map of commands to their functions
commands :: Map String CommandHandle
commands = fromList $ [ ("help", help)
                      , ("openBook", openBook)
                      ]

-- | Main export, runs a command given with its args
runCommand :: DiscordHandle -> Message -> [String] -> IO (Maybe String)
runCommand _ _ [] = error $ "No args given to runCommand!"
runCommand dis msg args =
    case lookup (head args) commands of
        Nothing -> return $ Just "Command not found."
        Just fn -> fn dis msg (tail args)
    
-- * COMMANDS START HERE
help :: CommandHandle
help dis msg args = pure (Just "what the frick")

openBook :: CommandHandle
openBook dis msg args = pure Nothing