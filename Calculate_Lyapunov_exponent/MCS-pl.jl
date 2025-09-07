using DynamicalSystems

# === 1) MCS 系统方程 ===
function mcs!(du, u, p, t)
    x1, x2, x3, x4 = u
    a, b, c, d, h = p
    du[1] = a * (2*x4^2 * (x2 - x1) + d*x1)
    du[2] = b * (2*x4^2 * (x1 - x2) - x3)
    du[3] = c * (x2 - h*x3)
    du[4] = x2 - x1 - 0.01*x4
end

# === 2) 参数 ===
a, b, c, d, h = 30.0, 1.0, 36.0, 0.5, 0.003
p = (a, b, c, d, h)

# === 3) 初值 ===
u0 = [0.1, -0.1, -0.1, 0.1]

# === 4) 创建系统 ===
ds = ContinuousDynamicalSystem(mcs!, u0, p)

# === 5) 计算 Lyapunov 指数谱 ===
Δt = 0.1
num_steps = 13000   # 积分步数，保证收敛
λs = lyapunovspectrum(ds, num_steps, Δt = Δt)

println("Lyapunov Exponents:", λs)
