function output = add_noise(input)
input = double(input);
noise = 0.05*(max(input(:)) - min(input(:)))*randn(size(input));
output = input + noise;
end