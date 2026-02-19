execute store result score @s boatYaw run data get entity @s Rotation[0] 100
execute if score @s boatYaw matches ..-1 run scoreboard players add @s boatYaw 36000

scoreboard players operation @s alignment = @s boatYaw
scoreboard players operation @s alignment -= global windYaw

execute if score @s alignment matches 18000.. run scoreboard players remove @s alignment 36000
execute if score @s alignment matches ..-18000 run scoreboard players add @s alignment 36000

execute at @s run function vehicles:display

execute if score @s alignment matches ..-1 run scoreboard players operation @s alignment *= constant constant

execute if score @s alignment matches 0..2000 run scoreboard players set @s maxSpeed 0
execute if score @s alignment matches 2001..4000 run scoreboard players set @s maxSpeed 50
execute if score @s alignment matches 4001..5000 run scoreboard players set @s maxSpeed 100
execute if score @s alignment matches 5001..8000 run scoreboard players set @s maxSpeed 200
execute if score @s alignment matches 8001..12000 run scoreboard players set @s maxSpeed 300
execute if score @s alignment matches 12001..16000 run scoreboard players set @s maxSpeed 200
execute if score @s alignment matches 16001..18000 run scoreboard players set @s maxSpeed 100

scoreboard players operation @s drag = @s sailSpeed
scoreboard players operation @s drag /= constant dragCoef

scoreboard players operation @s maxSpeed *= global windSpeed
execute if score @s sailSpeed < @s maxSpeed run scoreboard players operation @s sailSpeed += global windSpeed
execute if score @s sailSpeed > @s maxSpeed run scoreboard players operation @s sailSpeed -= @s drag
execute if score @s sailSpeed > @s maxSpeed run scoreboard players operation @s sailSpeed -= constant dragConst

# keep minecraft updating the boat
execute if score @s jitter matches 1.. run scoreboard players set @s jitter -2
scoreboard players add @s jitter 1
scoreboard players operation @s sailSpeed += @s jitter

execute at @s run function vehicles:motion_lookup
scoreboard players operation @s motionX *= @s sailSpeed
scoreboard players operation @s motionZ *= @s sailSpeed

execute store result storage vehicles:temp mx double 0.000001 run scoreboard players get @s motionX
execute store result storage vehicles:temp mz double 0.000001 run scoreboard players get @s motionZ
execute at @s run function vehicles:set_motion with storage vehicles:temp
