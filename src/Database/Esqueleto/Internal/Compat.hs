{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE PatternSynonyms  #-}
module Database.Esqueleto.Internal.Compat
    where

import           Database.Esqueleto.Internal.Internal
import           Database.Esqueleto.Internal.PersistentImport

type Value a = a
pattern Value :: a -> a
pattern Value a = a
unValue :: Value a -> a
unValue = id

-- | @valJ@ is like @val@ but for something that is already a @Value@. The use
-- case it was written for was, given a @Value@ lift the @Key@ for that @Value@
-- into the query expression in a type safe way. However, the implementation is
-- more generic than that so we call it @valJ@.
--
-- Its important to note that the input entity and the output entity are
-- constrained to be the same by the type signature on the function
-- (<https://github.com/prowdsponsor/esqueleto/pull/69>).
--
-- @since 1.4.2
valJ
    :: (PersistField (Key entity))
    => Value (Key entity)
    -> SqlExpr (Key entity)
valJ = val . unValue
