scoreboard objectives add bb_death deathCount
scoreboard objectives setdisplay sidebar bb_death
execute as @s[scores={bb_death=1}] run summon pig ~ ~ ~ {CustomName:"\"Reuben\""}
execute as @s[scores={bb_death=1}] at @s run tag @e add bb_death_item 
execute as @e[scores={bb_death=1}] at @s run scoreboard players set @s bb_death 0

tag @e[nbt={Inventory:{id:"minecraft:iron_trapdoor",Count:1b}}] add bb_item_grave
execute at @e[type=item,tag=bb_death_item] at @e run data get entity @s {Age:0s}
execute as @s[type=leash_knot,tag=bb_center_grave] at @s run summon armor_stand ~ ~-0.5 ~ {Marker:1b,Small:1b,Tags:["\"bb_gravestone\""]}
execute as @s[type=leash_knot,tag=bb_center_grave] at @s run execute as @e[type=armor_stand,tag=bb_gravestone,limit=1] at @e if block ~ ~ ~ air run setblock ~ ~ ~ minecraft:iron_trapdoor{facing:south,half:bottom,open:false} replace
execute as @s[type=leash_knot,tag=bb_center_grave] at @s run kill @s[type=leash_knot,tag=bb_center_grave]
execute as @s[type=armor_stand,tag=bb_gravestone] at @s run teleport @e[type=item,tag=bb_death_item,distance=..7] ~ ~0.2 ~
execute as @s[type=armor_stand,tag=bb_gravestone] if block ~ ~ ~ air run tag @s add bb_remove_grave
execute as @s[type=armor_stand,tag=bb_gravestone] run tag @s add bb_no_grave_item
execute as @s[type=armor_stand,tag=bb_gravestone] run execute as @e[type=item,tag=bb_death_item,distance=..1] run tag @e[type=armor_stand,tag=bb_gravestone,distance=..1] remove bb_no_grave_item
execute at @e[type=armor_stand,tag=bb_no_grave_item] run tag @s[type=armor_stand,tag=bb_no_grave_item] add bb_remove_grave

execute at @e[type=armor_stand,tag=bb_remove_grave] if block ~ ~ ~ iron_trapdoor run setblock ~ ~ ~ air replace
execute at @e[type=armor_stand,tag=bb_remove_grave] run kill @e[type=item,tag=bb_item_grave,distance=..5,limit=1]
execute at @e[type=armor_stand,tag=bb_remove_grave] run kill @s[type=armor_stand,tag=bb_remove_grave]
