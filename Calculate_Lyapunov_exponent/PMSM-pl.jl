using DynamicalSystems

# 定义 PMSM 系统的方程
function pmsm!(du, u, p, t)
    sigma, gamma = p
    id, omega, iq = u
    du[1] = -id + omega * iq                # d轴电流方程
    du[2] = sigma * (iq - omega)            # 速度方程
    du[3] = -iq - omega * id + gamma * omega # q轴电流方程
end

# 1. 冻结 id (固定电流 d 轴)
function pmsm_xz_frozen_id!(du, u, p, t)
    sigma, gamma, id0 = p
    omega, iq = u
    du[1] = -id0 + omega * iq                # d轴电流冻结
    du[2] = sigma * (iq - omega)            # 速度方程
    du[3] = -iq - omega * id0 + gamma * omega # q轴电流方程
end

# 2. 冻结 omega (固定转速)
function pmsm_xz_frozen_omega!(du, u, p, t)
    sigma, gamma, omega0 = p
    id, iq = u
    du[1] = -id + omega0 * iq                # d轴电流方程
    du[2] = sigma * (iq - omega0)            # 速度方程
    du[3] = -iq - omega0 * id + gamma * omega0 # q轴电流方程
end

# 3. 冻结 iq (固定电流 q 轴)
function pmsm_xz_frozen_iq!(du, u, p, t)
    sigma, gamma, iq0 = p
    id, omega = u
    du[1] = -id + omega * iq0                # d轴电流方程
    du[2] = sigma * (iq0 - omega)            # 速度方程
    du[3] = -iq0 - omega * id + gamma * omega # q轴电流方程
end

# 系统参数和初始条件
sigma, gamma = 5.6, 25.0
u0 = [0.4967, 0.6477, -0.1383]  # 初始条件 [id, omega, iq]
p = [sigma, gamma]

# 创建原始系统的连续动力学系统
ds = ContinuousDynamicalSystem(pmsm!, u0, p)

# 计算李雅普诺夫指数谱
num_steps = 20000
lyapunov_exponents = lyapunovspectrum(ds, num_steps, Δt = 0.02)
println("Lyapunov Exponents (original system):", lyapunov_exponents)

# 1. 冻结 id (固定电流 d 轴)
id0 = 0.4967  # 使用原始的 id 作为冻结值
ds_frozen_id = ContinuousDynamicalSystem(pmsm_xz_frozen_id!, [u0[2], u0[3]], [sigma, gamma, id0])
lyapunov_frozen_id = lyapunovspectrum(ds_frozen_id, num_steps, Δt = 0.02)
println("Lyapunov Exponents (freeze id):", lyapunov_frozen_id)

# 2. 冻结 omega (固定转速)
omega0 = 0.6477  # 使用原始的 omega 作为冻结值
ds_frozen_omega = ContinuousDynamicalSystem(pmsm_xz_frozen_omega!, [u0[1], u0[3]], [sigma, gamma, omega0])
lyapunov_frozen_omega = lyapunovspectrum(ds_frozen_omega, num_steps, Δt = 0.02)
println("Lyapunov Exponents (freeze omega):", lyapunov_frozen_omega)

# 3. 冻结 iq (固定电流 q 轴)
iq0 = -0.1383  # 使用原始的 iq 作为冻结值
ds_frozen_iq = ContinuousDynamicalSystem(pmsm_xz_frozen_iq!, [u0[1], u0[2]], [sigma, gamma, iq0])
lyapunov_frozen_iq = lyapunovspectrum(ds_frozen_iq, num_steps, Δt = 0.02)
println("Lyapunov Exponents (freeze iq):", lyapunov_frozen_iq)
