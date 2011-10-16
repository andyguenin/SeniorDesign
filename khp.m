function [ k,h,p ] = khp( w, de, t, di, r )
               %% spring constant
               % The spring constant is set so that if all of the weight of the
               % entire sphere is on one spring, it will only deform (rest_deformation)
               % mm.
               k = w / r;

               %% hop height
               TEc = w * (di - de ) + k * de ^2 / 2;
               if de == r || TEc < w * di
                   h = 0;
               else
                   h = (TEc - di * w)/w;
               end
               
               %% power requirement
               p = .5 * k * de^2 / t;

end

