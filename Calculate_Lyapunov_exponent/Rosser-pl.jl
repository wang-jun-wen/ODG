using DynamicalSystems

# 定义 Rössler 系统的方程
function rossler!(du, u, p, t)
    a, b, c = p
    x, y, z = u
    du[1] = -y - z
    du[2] = x + a * y
    du[3] = b + z * (x - c)
end

# 系统参数和初始条件
a, b, c = 0.2, 0.2, 5.7
u0 = [0.13810645,-0.26417572,1.21724914];
p = [a, b, c]

# 创建连续动力系统
ds = ContinuousDynamicalSystem(rossler!, u0, p)

# 计算李雅普诺夫指数谱
num_steps = 15400
lyapunov_exponents = lyapunovspectrum(ds, num_steps, Δt = 0.10)

println("Lyapunov Exponents:", lyapunov_exponents)
