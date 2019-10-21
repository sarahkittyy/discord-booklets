module Dispatch
( dispatch
) where
    
import Discord
import Discord.Types
import qualified Discord.Requests as R

import Util (isFromBot)
import Control.Monad (when)

-- | Main discord event handler.
dispatch :: DiscordHandle -> Event -> IO ()
dispatch dis evt = do
    case evt of
        _ -> return ()
    return ()