module Util
( isFromBot
) where
    
import Discord.Types (Message, userIsBot, messageAuthor)

-- | Returns true if the message originated from a bot.
isFromBot :: Message -> Bool
isFromBot = userIsBot . messageAuthor