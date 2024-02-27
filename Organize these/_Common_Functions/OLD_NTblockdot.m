function [outdata, outshape, permuteOrder1, permuteOrder2, tmp1, tmp2] = NTblockdot(obj, other, legs1, legs2, shape1, shape2)
 % Performs tensor dot for dense blocks..
            % ------------------------
            % obj:          the first tensor to be contracted.
            % other:        the other tensor to be contracted.
            % legs1:        the legs of "obj" which are contracted with the
            %               ones listed in legs2.
            % legs2:        the legs of "other" which are contracted with
            %               the ones listed in legs1.
            % shape1:       leg dimensions of obj. (May have ones at the
            %               end, that's why we need it.
            % shape2        leg dimensions of other.

            freeLegs1 = 1:length(shape1);
            %freeLegs1(ismember(freeLegs1,legs1)) = [];  TOO SLOW
            freeLegs1(legs1) = [];
            if length(shape1) == 1
                permuteOrder1 = [2,1];
            else
                permuteOrder1 = [freeLegs1,legs1];
            end
            newshape1 = shape1;
            newshape1(legs1) = [];
            
            freeLegs2 = 1:length(shape2);
            %freeLegs2(ismember(freeLegs2,legs2)) = []; TOO SLOW
            freeLegs2(legs2) = [];
            if length(shape2) == 1
                permuteOrder2 = [1,2];
            else
                permuteOrder2 = [legs2, freeLegs2];
            end
            newshape2 = shape2;
            newshape2(legs2) = [];

            
            tmp1 = reshape(permute(obj, permuteOrder1), [prod(newshape1), prod(shape1(legs1))]);

            tmp2 = reshape(permute(other, permuteOrder2), [prod(shape2(legs2)), prod(newshape2)]);


            outshape = [newshape1, newshape2];
            if isempty(outshape)
                outdata = tmp1*tmp2;     % just a number
            elseif length(newshape1) + length(newshape2) == 1
                    outdata = reshape(tmp1 * tmp2, [newshape1, newshape2,1]);
            else
                    outdata = reshape(tmp1 * tmp2, [newshape1, newshape2]);
            end
           
            outdata = reshape(outdata, shape1);
            outdata = ipermute(outdata, permuteOrder1);
end


