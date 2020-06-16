c ID: denoise.f, last updated 2020-05-10, F.Osorio

cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      SUBROUTINE denoise(x, ldx, nrow, ncol, y, ldy, looks, dip, task)
      INTEGER          ldx, nrow, ncol, ldy, task
      DOUBLE PRECISION x(ldx,*), y(ldy,*), looks, dip
c
c     remove noise from an image in grayscale
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
          else
            center = window(5)
            call enhanced_filter(window, 9, center, dip, looks, y(i,j))
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
        else
          center = window(5)
          call enhanced_filter(window, 9, center, dip, looks, y(i,j))
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
        else
          center = window(5)
          call enhanced_filter(window, 9, center, dip, looks, y(i,j))
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
        else
          center = window(5)
          call enhanced_filter(window, 9, center, dip, looks, y(i,j))
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
        else
          center = window(5)
          call enhanced_filter(window, 9, center, dip, looks, y(i,j))
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
      else
        center = window(5)
        call enhanced_filter(window, 9, center, dip, looks, y(i,j))
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
      else
        center = window(5)
        call enhanced_filter(window, 9, center, dip, looks, y(i,j))
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
      else
        center = window(5)
        call enhanced_filter(window, 9, center, dip, looks, y(i,j))
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
      else
        center = window(5)
        call enhanced_filter(window, 9, center, dip, looks, y(i,j))
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
      DOUBLE PRECISION M
      PARAMETER       (M = 1.0d0)
c
c     .. executable statements ..
c
      call moments(window, n, mean, var)
c
      weight = M * var / (M**2 * var + mean**2 / looks)
      pixel = mean + weight * (center - M * mean)
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
c
c     .. executable statements ..
c
      call moments(window, n, mean, var)
c
      noise = 1.0d0 / SQRT(looks)
      cmax = SQRT(1.0d0 + 2.0d0 / looks)
      cv = SQRT(var) / mean
      weight = EXP(-dip * (cv - noise) / (cmax - cv))
      if (cv .LE. noise) then
        pixel = mean
      else if ((noise .LT. cv) .AND. (cv .LT. cmax)) then
        pixel = mean * weight + center * (1.0d0 - weight)
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
      DOUBLE PRECISION mean, var, cv, noise, weight
c
c     .. executable statements ..
c
      call moments(window, n, mean, var)
c
      noise = 1.0d0 / SQRT(looks)
      cv = SQRT(var) / mean
      weight = (1.0d0 - (noise / cv)**2) / (1 + noise**2)
      pixel = weight * center + (1.0d0 - weight) * mean
c
      return
      END
