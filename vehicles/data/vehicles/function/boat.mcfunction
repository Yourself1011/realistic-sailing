execute store result score @s boatYaw run data get entity @s Rotation[0] 100
execute if score @s boatYaw matches ..-1 run scoreboard players add @s boatYaw 36000

scoreboard players operation @s alignment = @s boatYaw
scoreboard players operation @s alignment -= global windYaw

execute if score @s alignment matches 18000.. run scoreboard players remove @s alignment 36000
execute if score @s alignment matches ..-18000 run scoreboard players add @s alignment 36000

scoreboard players operation @s localWindSpeed = global windSpeed
execute at @s if biome ~ ~ ~ #c:is_deep_ocean run scoreboard players operation @s localWindSpeed *= constant deepOceanCoef
execute at @s if biome ~ ~ ~ #c:is_deep_ocean run scoreboard players operation @s localWindSpeed /= constant ten

execute at @s run function vehicles:display

execute if score @s alignment matches ..-1 run scoreboard players operation @s alignment *= constant constant

execute if score @s alignment matches 0..1500 run scoreboard players set @s maxSpeed 0
execute if score @s alignment matches 1501..4000 run scoreboard players set @s maxSpeed 150
execute if score @s alignment matches 4001..6000 run scoreboard players set @s maxSpeed 250
execute if score @s alignment matches 6001..9000 run scoreboard players set @s maxSpeed 350
execute if score @s alignment matches 9001..13000 run scoreboard players set @s maxSpeed 400
execute if score @s alignment matches 13001..16000 run scoreboard players set @s maxSpeed 300
execute if score @s alignment matches 16001..18000 run scoreboard players set @s maxSpeed 200

scoreboard players operation @s drag = @s sailSpeed
scoreboard players operation @s drag /= constant dragCoef

scoreboard players operation @s maxSpeed *= @s localWindSpeed
execute if score @s sailSpeed < @s maxSpeed run scoreboard players operation @s sailSpeed += @s localWindSpeed
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
