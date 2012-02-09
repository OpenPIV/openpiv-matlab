function vector = fill_holes(vector,reslenx,resleny)

% new approach. use inpaint_nans, thanks to John D'Errico
% Aug 11, 2009
% Alex Liberzon (alex.liberzon@gmail.com)
% See also INPAINT_NANS
%

vector(abs(vector)==0) = NaN;
vector = inpaint_nans(real(vector)) + i*inpaint_nans(imag(vector));

% [indx,indy] = find(~abs(vector));
%
% while ~isempty(indx)
%     for z=1:length(indx)
%         k = [max(3,indx(z))-2:min(resleny-2,indx(z))+2];
%         m = [max(3,indy(z))-2:min(reslenx-2,indy(z))+2];
%         try
%             tmpvec = vector(k,m);
%             tmpvec = tmpvec(find(tmpvec));
%             vector(indx(z),indy(z)) = mean(real(tmpvec))+ sqrt(-1)*mean(imag(tmpvec));
%         catch
%             indx = [];
%         end
%         try
%             [indx,indy] = find(~abs(vector));
%         catch
%             indx = [];
%         end
%     end
% end
return