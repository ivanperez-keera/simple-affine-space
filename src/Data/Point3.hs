{-# LANGUAGE ExistentialQuantification, MultiParamTypeClasses, FlexibleInstances, StandaloneDeriving #-}
{-# OPTIONS_GHC -fno-warn-warnings-deprecations #-}
-----------------------------------------------------------------------------------------
-- |
-- Module      :  Data.Point3
-- Copyright   :  (c) Antony Courtney and Henrik Nilsson, Yale University, 2003
-- License     :  BSD-style (see the LICENSE file in the distribution)
--
-- Maintainer  :  ivan.perez@keera.co.uk
-- Stability   :  provisional
-- Portability :  non-portable (GHC extensions)
--
-- 3D point abstraction (R^3).
--
-----------------------------------------------------------------------------------------
module Data.Point3 (
    Point3(..), -- Non-abstract, instance of AffineSpace
    point3X,    -- :: RealFloat a => Point3 a -> a
    point3Y,    -- :: RealFloat a => Point3 a -> a
    point3Z     -- :: RealFloat a => Point3 a -> a
) where

import Control.DeepSeq (NFData(..))

import Data.VectorSpace ()
import Data.AffineSpace
import Data.Vector3

-- * 3D point, constructors and selectors

-- | 3D point.
data Point3 a = RealFloat a => Point3 !a !a !a

deriving instance Eq a => Eq (Point3 a)

deriving instance Show a => Show (Point3 a)

instance NFData a => NFData (Point3 a) where
  rnf (Point3 x y z) = rnf x `seq` rnf y `seq` rnf z `seq` ()

-- | X coodinate of a 3D point.
point3X :: RealFloat a => Point3 a -> a
point3X (Point3 x _ _) = x

-- | Y coodinate of a 3D point.
point3Y :: RealFloat a => Point3 a -> a
point3Y (Point3 _ y _) = y

-- | Z coodinate of a 3D point.
point3Z :: RealFloat a => Point3 a -> a
point3Z (Point3 _ _ z) = z

-- * Affine space instance

instance RealFloat a => AffineSpace (Point3 a) (Vector3 a) a where
    origin = Point3 0 0 0

    (Point3 x y z) .+^ v =
        Point3 (x + vector3X v) (y + vector3Y v) (z + vector3Z v)

    (Point3 x y z) .-^ v =
        Point3 (x - vector3X v) (y - vector3Y v) (z - vector3Z v)

    (Point3 x1 y1 z1) .-. (Point3 x2 y2 z2) =
        vector3 (x1 - x2) (y1 - y2) (z1 - z2)
