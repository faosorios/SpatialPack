c ID: denoise.f, last updated 2020-05-19, F.Osorio

cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      SUBROUTINE denoise(x, ldx, nrow, ncol, y, ldy, looks, dip, task)
      INTEGER          ldx, nrow, ncol, ldy, task
      DOUBLE PRECISION x(ldx,*), y(ldy,*), looks, dip
c
c     denoise remove additive or multiplicative noise from an image in grayscale
c
c     parameters:
c     x     - double precision array of dimension nrow-by-ncol.
c           contains the image matrix that will be filtered.
c           unchanged on exit.
c     ldx   - integer.
c           on entry, ldx specifies the leading dimension of image x.
c           unchanged on exit.
c     nrow  - integer.
c           on entry, nrow specifies the number of rows of the matrix x.
c           unchanged on exit.
c     ncol  - integer.
c           on entry, ncol specifies the number of columns of the matrix x.
c           unchanged on exit.
c     y     - double precision array of dimension nrow-by-ncol.
c           y is overwritten by the filtered image.
c     ldy   - integer.
c           on entry, ldy specifies the leading dimension of image y.
c           unchanged on exit.
c     looks - double precision.
c           on entry, looks specifies the equivalent (or effective) number
c           of looks used to estimate noise variance, and it effectively
c           controls the amount of smoothing applied to the image by the filter
c           unchanged on exit.
c     dip   - double precision.
c           on entry, dip specifies the extent of exponential damping effect
c           on filtering
c           unchanged on exit.
c     task  - integer.
c           on entry, specifies the type of filter to be used, as follows:
c             task = 0: median filter
c             task = 1: Lee filter
c             task = 2: enhanced Lee filter
c             task = 3: Kuan filter
c             task = 4: Nathan filter
c           unchanged on exit.
c
      INTEGER          i, j
      DOUBLE PRECISION window(9), center

c
c     Process the main part of the image
c
      do i = 2, nrow - 1
        do j = 2, ncol - 1
          window(1) = x(i - 1, j - 1)
          window(2) = x(i - 1, j)
          window(3) = x(i - 1, j + 1)
          window(4) = x(i, j - 1)
          window(5) = x(i, j)
          window(6) = x(i, j + 1)
          window(7) = x(i + 1, j - 1)
          window(8) = x(i + 1, j)
          window(9) = x(i + 1, j + 1)
          if (task .EQ. 0) then
            call median_filter(window, 9, y(i,j))
          else if (task .EQ. 1) then
            center = window(5)
            call lee_filter(window, 9, center, looks, y(i,j))
          else if (task .EQ. 2) then
            center = window(5)
            call enhanced_filter(window, 9, center, dip, looks, y(i,j))
          else if (task .EQ. 3) then
            center = window(5)
            call kuan_filter(window, 9, center, looks, y(i,j))
          else
            center = window(5)
            call nathan_filter(window, 9, center, y(i,j))
          end if
        end do
      end do

c
c     Process the four borders
c
      do i = 2, nrow - 1
        j = 1
        window(1) = x(i - 1, j)
        window(2) = x(i - 1, j + 1)
        window(3) = x(i - 1, j + 2)
        window(4) = x(i, j)
        window(5) = x(i, j + 1)
        window(6) = x(i, j + 2)
        window(7) = x(i + 1, j)
        window(8) = x(i + 1, j + 1)
        window(9) = x(i + 1, j + 2)
        if (task .EQ. 0) then
          call median_filter(window, 9, y(i,j))
        else if (task .EQ. 1) then
          center = window(5)
          call lee_filter(window, 9, center, looks, y(i,j))
        else if (task .EQ. 2) then
          center = window(5)
          call enhanced_filter(window, 9, center, dip, looks, y(i,j))
        else if (task .EQ. 3) then
          center = window(5)
          call kuan_filter(window, 9, center, looks, y(i,j))
        else
          center = window(5)
          call nathan_filter(window, 9, center, y(i,j))
        end if

        j = ncol
        window(1) = x(i - 1, j - 2)
        window(2) = x(i - 1, j - 1)
        window(3) = x(i - 1, j)
        window(4) = x(i, j - 2)
        window(5) = x(i, j - 1)
        window(6) = x(i, j)
        window(7) = x(i + 1, j - 2)
        window(8) = x(i + 1, j - 1)
        window(9) = x(i + 1, j)
        if (task .EQ. 0) then
          call median_filter(window, 9, y(i,j))
        else if (task .EQ. 1) then
          center = window(5)
          call lee_filter(window, 9, center, looks, y(i,j))
        else if (task .EQ. 2) then
          center = window(5)
          call enhanced_filter(window, 9, center, dip, looks, y(i,j))
        else if (task .EQ. 3) then
          center = window(5)
          call kuan_filter(window, 9, center, looks, y(i,j))
        else
          center = window(5)
          call nathan_filter(window, 9, center, y(i,j))
        end if
      end do

      do j = 2, ncol - 1
        i = 1
        window(1) = x(i, j - 1)
        window(2) = x(i, j)
        window(3) = x(i, j + 1)
        window(4) = x(i + 1, j - 1)
        window(5) = x(i + 1, j)
        window(6) = x(i + 1, j + 1)
        window(7) = x(i + 2, j - 1)
        window(8) = x(i + 2, j)
        window(9) = x(i + 2, j + 1)
        if (task .EQ. 0) then
          call median_filter(window, 9, y(i,j))
        else if (task .EQ. 1) then
          center = window(5)
          call lee_filter(window, 9, center, looks, y(i,j))
        else if (task .EQ. 2) then
          center = window(5)
          call enhanced_filter(window, 9, center, dip, looks, y(i,j))
        else if (task .EQ. 3) then
          center = window(5)
          call kuan_filter(window, 9, center, looks, y(i,j))
        else
          center = window(5)
          call nathan_filter(window, 9, center, y(i,j))
        end if

        i = nrow
        window(1) = x(i - 2, j - 1)
        window(2) = x(i - 2, j)
        window(3) = x(i - 2, j + 1)
        window(4) = x(i - 1, j - 1)
        window(5) = x(i - 1, j)
        window(6) = x(i - 1, j + 1)
        window(7) = x(i, j - 1)
        window(8) = x(i, j)
        window(9) = x(i, j + 1)
        if (task .EQ. 0) then
          call median_filter(window, 9, y(i,j))
        else if (task .EQ. 1) then
          center = window(5)
          call lee_filter(window, 9, center, looks, y(i,j))
        else if (task .EQ. 2) then
          center = window(5)
          call enhanced_filter(window, 9, center, dip, looks, y(i,j))
        else if (task .EQ. 3) then
          center = window(5)
          call kuan_filter(window, 9, center, looks, y(i,j))
        else
          center = window(5)
          call nathan_filter(window, 9, center, y(i,j))
        end if
      end do

c
c     Process the four corners
c
      i = 1
      j = 1
      window(1) = x(i, j)
      window(2) = x(i, j + 1)
      window(3) = x(i, j + 2)
      window(4) = x(i + 1, j)
      window(5) = x(i + 1, j + 1)
      window(6) = x(i + 1, j + 2)
      window(7) = x(i + 2, j)
      window(8) = x(i + 2, j + 1)
      window(9) = x(i + 2, j + 2)
      if (task .EQ. 0) then
        call median_filter(window, 9, y(i,j))
      else if (task .EQ. 1) then
        center = window(5)
        call lee_filter(window, 9, center, looks, y(i,j))
      else if (task .EQ. 2) then
        center = window(5)
        call enhanced_filter(window, 9, center, dip, looks, y(i,j))
      else if (task .EQ. 3) then
        center = window(5)
        call kuan_filter(window, 9, center, looks, y(i,j))
      else
        center = window(5)
        call nathan_filter(window, 9, center, y(i,j))
      end if

      i = 1
      j = ncol
      window(1) = x(i, j - 2)
      window(2) = x(i, j - 1)
      window(3) = x(i, j)
      window(4) = x(i + 1, j - 2)
      window(5) = x(i + 1, j - 1)
      window(6) = x(i + 1, j)
      window(7) = x(i + 2, j - 2)
      window(8) = x(i + 2, j - 1)
      window(9) = x(i + 2, j)
      if (task .EQ. 0) then
        call median_filter(window, 9, y(i,j))
      else if (task .EQ. 1) then
        center = window(5)
        call lee_filter(window, 9, center, looks, y(i,j))
      else if (task .EQ. 2) then
        center = window(5)
        call enhanced_filter(window, 9, center, dip, looks, y(i,j))
      else if (task .EQ. 3) then
        center = window(5)
        call kuan_filter(window, 9, center, looks, y(i,j))
      else
        center = window(5)
        call nathan_filter(window, 9, center, y(i,j))
      end if

      i = nrow
      j = 1
      window(1) = x(i - 2, j)
      window(2) = x(i - 1, j)
      window(3) = x(i, j)
      window(4) = x(i - 2, j + 1)
      window(5) = x(i - 1, j + 1)
      window(6) = x(i, j + 1)
      window(7) = x(i - 2, j + 2)
      window(8) = x(i - 1, j + 2)
      window(9) = x(i, j + 2)
      if (task .EQ. 0) then
        call median_filter(window, 9, y(i,j))
      else if (task .EQ. 1) then
        center = window(5)
        call lee_filter(window, 9, center, looks, y(i,j))
      else if (task .EQ. 2) then
        center = window(5)
        call enhanced_filter(window, 9, center, dip, looks, y(i,j))
      else if (task .EQ. 3) then
        center = window(5)
        call kuan_filter(window, 9, center, looks, y(i,j))
      else
        center = window(5)
        call nathan_filter(window, 9, center, y(i,j))
      end if

      i = nrow
      j = ncol
      window(1) = x(i - 2, j - 2)
      window(2) = x(i - 2, j - 1)
      window(3) = x(i - 2, j)
      window(4) = x(i - 1, j - 2)
      window(5) = x(i - 1, j - 1)
      window(6) = x(i - 1, j)
      window(7) = x(i, j - 2)
      window(8) = x(i, j - 1)
      window(9) = x(i, j)
      if (task .EQ. 0) then
        call median_filter(window, 9, y(i,j))
      else if (task .EQ. 1) then
        center = window(5)
        call lee_filter(window, 9, center, looks, y(i,j))
      else if (task .EQ. 2) then
        center = window(5)
        call enhanced_filter(window, 9, center, dip, looks, y(i,j))
      else if (task .EQ. 3) then
        center = window(5)
        call kuan_filter(window, 9, center, looks, y(i,j))
      else
        center = window(5)
        call nathan_filter(window, 9, center, y(i,j))
      end if
c
      return
      END

      SUBROUTINE median_filter(window, n, pixel)
      INTEGER          n
      DOUBLE PRECISION window(*), pixel
c
c     median filter to remove noise from a grayscale image
c
c     .. local scalars ..
      DOUBLE PRECISION median
c
c     .. executable statements ..
c
      pixel = median(window, n)
c
      return
      END

cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      SUBROUTINE lee_filter(window, n, center, looks, pixel)
      INTEGER          n
      DOUBLE PRECISION window(*), center, looks, pixel
c
c     Lee filter to remove multiplicative noise from a grayscale image
c
c     .. local scalars ..
      DOUBLE PRECISION mean, var, weight
      DOUBLE PRECISION ZERO
      PARAMETER (ZERO = 0.0d0)
c
c     .. executable statements ..
c
      call moments(window, n, mean, var)
c
      weight = var / (var + mean**2 / looks)
      if (weight .GT. ZERO) then
        pixel = mean + weight * (center - mean)
      else
        pixel = mean
      end if
c
      return
      END

cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      SUBROUTINE enhanced_filter(window, n, center, dip, looks, pixel)
      INTEGER          n
      DOUBLE PRECISION window(*), center, dip, looks, pixel
c
c     Lee filter to remove multiplicative noise from a grayscale image
c
c     .. local scalars ..
      DOUBLE PRECISION mean, var, cmax, cv, noise, weight
      DOUBLE PRECISION ZERO, ONE, TWO
      PARAMETER (ZERO = 0.0d0, ONE = 1.0d0, TWO = 0.0d0)
c
c     .. executable statements ..
c
      call moments(window, n, mean, var)
c
      noise = ONE / SQRT(looks)
      cmax = SQRT(ONE + TWO / looks)
      cv = SQRT(var) / mean
      weight = EXP(-dip * (cv - noise) / (cmax - cv))
      if (cv .LE. noise) then
        pixel = mean
      else if ((noise .LT. cv) .AND. (cv .LT. cmax)) then
        pixel = mean * weight + center * (ONE - weight)
      else if (cv .GE. cmax) then
        pixel = center
      end if
c
      return
      END

cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      SUBROUTINE kuan_filter(window, n, center, looks, pixel)
      INTEGER          n
      DOUBLE PRECISION window(*), center, looks, pixel
c
c     Kuan filter to remove multiplicative noise from a grayscale image
c
c     .. local scalars ..
      DOUBLE PRECISION mean, var, sharpe2, weight
      DOUBLE PRECISION ZERO, ONE
      PARAMETER (ZERO = 0.0d0, ONE = 1.0d0)
c
c     .. executable statements ..
c
      call moments(window, n, mean, var)
c
      sharpe2 = mean**2 / var
      weight = (looks - sharpe2) / (looks + ONE)
      if (weight .GT. ZERO) then
        pixel = mean + weight * (center - mean)
      else
        pixel = mean
      end if
c
      return
      END

cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      SUBROUTINE nathan_filter(window, n, center, pixel)
      INTEGER          n
      DOUBLE PRECISION window(*), center, pixel
c
c     Nathan filter to remove multiplicative noise from a grayscale image
c     (suitable to 1-look SAR images only)
c
c     .. local scalars ..
      DOUBLE PRECISION mean, var, weight
      DOUBLE PRECISION ZERO, HALF, ONE
      PARAMETER (ZERO = 0.0d0, HALF = 0.5d0, ONE = 1.0d0)
c
c     .. executable statements ..
c
      call moments(window, n, mean, var)
c
      weight = HALF * (ONE - (mean**2 / var))
      if (weight .GT. ZERO) then
        pixel = mean + weight * (center - mean)
      else
        pixel = mean
      end if
c
      return
      END

cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      SUBROUTINE gamma_filter(window, n, center, looks, pixel)
      INTEGER          n
      DOUBLE PRECISION window(*), center, looks, pixel
c
c     Gamma filter to remove multiplicative noise from a grayscale image
c
c     .. local scalars ..
      DOUBLE PRECISION mean, var, a, b, cv, discr
      DOUBLE PRECISION ZERO, ONE, TWO, FOUR
      PARAMETER (ZERO = 0.0d0, ONE = 1.0d0, TWO = 2.0d0, FOUR = 4.0d0)
c
c     .. executable statements ..
c
      call moments(window, n, mean, var)
c
      cv = SQRT(var) / mean
      a  = (looks + ONE) / (looks * cv**2 - ONE)
      b  = a - looks - ONE
      discr = (mean * b)**2 + FOUR * a * looks * mean * center
      if (discr .GE. ZERO) then
        pixel = (b * mean + SQRT(discr)) / (TWO * a)
      else
        pixel = mean
      end if
c
      return
      END

cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      SUBROUTINE mmse_filter(window, n, center, looks, pixel)
      INTEGER          n
      DOUBLE PRECISION window(*), center, looks, pixel
c
c     yet another verion of the Lee minimum mean square error filter to
c     remove multiplicative noise from a grayscale image
c
c     .. local scalars ..
      DOUBLE PRECISION mean, var, weight
      DOUBLE PRECISION ZERO
      PARAMETER (ZERO = 0.0d0)
c
c     .. executable statements ..
c
      call moments(window, n, mean, var)
c
      weight = (var - mean**2 / looks) / (var + (mean / looks)**2)
      if (weight .GT. ZERO) then
        pixel = mean + weight * (center - mean)
      else
        pixel = mean
      end if
c
      return
      END
