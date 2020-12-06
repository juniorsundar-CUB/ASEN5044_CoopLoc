function [out] = WrapY(in)
    out = in;
    out(1,:) = wrapToPi(out(1,:));
    out(3,:) = wrapToPi(out(3,:));
end
