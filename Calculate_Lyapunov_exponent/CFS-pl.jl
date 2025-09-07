using DynamicalSystems

# 定义 CFS 系统的方程
function cfs!(du, u, p, t)
    a, b, c = p
    x1, y1, z1 = u
    du[1] = z1 + (y1 - a) * x1         # x1 方程
    du[2] = 1 - b * y1 - x1^2          # y1 方程
    du[3] = -x1 - c * z1               # z1 方程
end

# 系统参数和初始条件
a, b, c = 1.0, 0.3, 1.3
u0 = [-0.31964895, -0.44161103, 0.84844681]  # 初始条件
p = [a, b, c]                                # 参数

# 创建连续动力系统
ds = ContinuousDynamicalSystem(cfs!, u0, p)

# 计算李雅普诺夫指数谱
num_steps = 13000
lyapunov_exponents = lyapunovspectrum(ds, num_steps, Δt = 0.1)

println("Lyapunov Exponents:", lyapunov_exponents)
