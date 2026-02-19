execute if score global windSpeedTimer matches ..0 run execute store result score global windSpeedTarget run random value 30..60
execute if score global windSpeedTimer matches ..0 run execute store result score global windSpeedTimer run random value 2400..6000
execute if score global windYawTimer matches ..0 run execute store result score global windYawTarget run random value 0..35999
execute if score global windYawTimer matches ..0 run execute store result score global windYawTimer run random value 2400..6000
execute if score global gustCooldown matches ..0 run execute store result score global gustTimer run random value 200..600
execute if score global gustCooldown matches ..0 run execute store result score global gustCooldown run random value 1200..2400

execute if score global windSpeed < global windSpeedTarget run scoreboard players add global windSpeed 1
execute if score global windSpeed > global windSpeedTarget run scoreboard players remove global windSpeed 1
execute if score global gustTimer matches 1.. run scoreboard players operation global windSpeed = global windSpeedTarget
execute if score global gustTimer matches 1.. run scoreboard players operation global windSpeed *= constant gustCoef
execute if score global windYaw < global windYawTarget run scoreboard players add global windYaw 100
execute if score global windYaw > global windYawTarget run scoreboard players remove global windYaw 100

scoreboard players remove global windSpeedTimer 1
scoreboard players remove global windYawTimer 1
scoreboard players remove global gustCooldown 1
scoreboard players remove global gustTimer 1
