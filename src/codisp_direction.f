c ID: codisp_direction.f, last updated 2020-06-15, F.Osorio

cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      SUBROUTINE hcodisp(x, ldx, nrow, ncol, y, ldy, h, coef)
      INTEGER          ldx, nrow, ncol, ldy, h(*)
      DOUBLE PRECISION x(ldx,*), y(ldy,*), coef
c
c     computes the codispersion coefficient for a direction h
c
      INTEGER          i, j, h1, h2
      DOUBLE PRECISION dx, dy, cross, sxx, syy

c
c     Process the main part of the image
c
      h1 = h(1)
      h2 = h(2)
      cross = 0.0d0
      sxx = 0.0d0
      syy = 0.0d0
c
      do i = 1, nrow - h1
          do j = 1, ncol - h2
            dx = x(i, j) - x(i + h1, j + h2)
            dy = y(i, j) - y(i + h1, j + h2)
            cross = cross + dx * dy;
            sxx = sxx + dx**2
            syy = syy + dy**2
          end do
      end do
c
      coef = cross / sqrt(sxx * syy)
c
      return
      END
