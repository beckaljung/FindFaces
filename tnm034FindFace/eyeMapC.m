function [eyeMap_output] = eyeMapC(cb, cr)

cb2 = power(cb, 2);

cr_neg = 1-cr;
cr2 = power(cr_neg, 2);

eyeMap_output = (1/3)*(cb2 + cr2 + (cb./cr));

end

