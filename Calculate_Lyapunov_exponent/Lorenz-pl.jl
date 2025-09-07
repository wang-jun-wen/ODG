using DynamicalSystems

# 定义 Lorenz 系统的方程
function lorenz!(du, u, p, t)
    sigma, rho, r = p
    x, y, z = u
    du[1] = sigma * (y - x)
    du[2] = x * (rho - z) - y
    du[3] = x * y- r * z
end

# 系统参数和初始条件
#sigma, rho, r = 10.0, 28.0, 8/3
sigma, rho, r = 10.0, 60, 8/3
u0 = [-0.2494, -0.1057, -0.113]
p = [sigma, rho, r]

# 创建连续动力系统
ds = ContinuousDynamicalSystem(lorenz!, u0, p)

# 计算李雅普诺夫指数谱
num_steps = 10400
lyapunov_exponents = lyapunovspectrum(ds, num_steps, Δt = 0.02)

println("Lyapunov Exponents:", lyapunov_exponents)
