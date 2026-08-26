
# IQsim.jl   simulates IQ data received by an antenna from a radiating source
using FFTW
using Plots
plotly()  # plotly backend for Plots 


j = im
c = 3.0E8
 
 
fs = 20E6
dt = 1/fs


Nsamples = 2^15;   # 32768 samples

t = (0:Nsamples-1)*dt

t_max = Nsamples*dt   # 0.0016384 s (1.6384 ms)

# Simulate a real 1MHz sinusoid and do an FFT and plot it

x = cos.(2*pi*1E6*t)   # Note the "." notation required because t is a range not a scalar


plot(t,x)

# Do FFT

X = fft(x)

plot( abs.(X), title="FFT of x" )

# plot( fftshift(abs.(X)), title="FFT of x" )  # fftshift function swaps two halves of an array

 # Simulate IQ representation of a received signal, frequency f0 = fc + 1MHz
 # Range to source R = 1000m

fc = 1E9
f0 = fc + 1E6
lambda0 = f0/c

R = 1000
tau = R/c   # delay from source to antenna element
 
A = 1

# Simulate IQ data at a receiving element
vref = A*exp(-j*2*pi*f0*tau)*exp.(j*(2*pi*f0-2*pi*fc)*t)   
 

VREF = fft(vref)



df = fs/N

f_axis = (0:N-1)*df

plot(f_axis, abs.(VREF))

 
  
 # Simulate source and signal received by an antenna
 
P = [100, 100]   #[Px Py]
A1 = [0, 1]
 
R = A1 - P

range = norm(R)

# Create an array of 5 antennas

Nant = 5
# Create an array of vectors (filled with zeros initially)
A = [zeros(Float64, 3) for _ in 1:Nant]

#A[1] = [1,0,0]   # [x,y,z]
#A[2] = [0,1,0]

# Define 5 antennas
Nant=5
Rcircle = lambda0/4;  # so diameter <= lambda/2

for n=1:Nant
    theta = 2*pi/Nant * (n-1)
    z=0
    x=Rcircle*cos(theta)
    y=Rcircle*sin(theta)
    A[n]=[x,y,z]
end

@show A

plt = scatter()    
for n=1:Nant
   scatter!( [ A[n][1] ] , [ A[n][2] ])
end
display(plt)

P = [5,10,0]
scatter!( [ P[1] ] , [ P[2] ])
 
# Calculate the distance from source to each antenna
for n=1:Nant
   Ant = A[n]
   R = Ant - P
@show   dist = norm(R)
end


unit_vec_x = [1,0,0]

@show angle_of_arrival = acos( dot(unit_vec_x,P)/norm(unit_vec_x)/norm(P) ) /pi*180


# Create an array of complex arrays to store IQ data
IQdata_storage = [zeros(ComplexF64, Nsamples) for _ in 1:Nant]

