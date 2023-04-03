{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE FlexibleInstances         #-}
{-# LANGUAGE MultiParamTypeClasses     #-}
{-# LANGUAGE StandaloneDeriving        #-}
{-# OPTIONS_GHC -fno-warn-warnings-deprecations #-}
--------------------------------------------------------------------------------
-- |
-- Module      :  Data.Point2
-- Copyright   :  (c) Antony Courtney and Henrik Nilsson, Yale University, 2003
-- License     :  BSD-style (see the LICENSE file in the distribution)
--
-- Maintainer  :  ivan.perez@keera.co.uk
-- Stability   :  provisional
-- Portability :  non-portable (GHC extensions)
--
-- 2D point abstraction (R^2).
--
--------------------------------------------------------------------------------
module Data.Point2
  ( Point2(..) -- Non-abstract, instance of AffineSpace
  , point2X    -- :: RealFloat a => Point2 a -> a
  , point2Y    -- :: RealFloat a => Point2 a -> a
  ) where

-- External imports
import Control.DeepSeq (NFData(..))

-- Internal imports
import Data.AffineSpace
import Data.Vector2
import Data.VectorSpace ()

-- * 2D point, constructors and selectors

-- | 2D point.
data Point2 a = RealFloat a => Point2 !a !a

deriving instance Eq a => Eq (Point2 a)

deriving instance Show a => Show (Point2 a)

instance NFData a => NFData (Point2 a) where
  rnf (Point2 x y) = rnf x `seq` rnf y `seq` ()

-- | X coordinate of a 2D point.
point2X :: RealFloat a => Point2 a -> a
point2X (Point2 x _) = x

-- | Y coordinate of a 2D point.
point2Y :: RealFloat a => Point2 a -> a
point2Y (Point2 _ y) = y

-- * Affine space instance

instance RealFloat a => AffineSpace (Point2 a) (Vector2 a) a where
  origin = Point2 0 0

  (Point2 x y) .+^ v = Point2 (x + vector2X v) (y + vector2Y v)

  (Point2 x y) .-^ v = Point2 (x - vector2X v) (y - vector2Y v)

  (Point2 x1 y1) .-. (Point2 x2 y2) = vector2 (x1 - x2) (y1 - y2)
