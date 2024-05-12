red = 21
yellow = 23


craftParams = {}

function createDirectory(path)
    local command = string.format("mkdir %s", path)
    os.execute(command)
    print("Directory created: " .. path)
end

--exists
function exists(file)
    local ok, err, code = os.rename(file, file)
    if not ok then
       if code == 13 then

          return true
       end
    end
    return ok, err
 end
--isdir
 function isdir(path)
    local path2 = path
    return exists(path2 .. "/")
 end
 --file exists
 function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
 end

function onPlace(x, y, z, blk)
    print(blk)
    if blk == 47 then
        craftParams[1] = x
        craftParams[2] = y
        craftParams[3] = z
        filek = io.open("moddata/crafting/table.txt", "w")
        filek:write(craftParams[1] .. '\n', craftParams[2] .. '\n', craftParams[3] .. '\n')
        filek:close()
    else
        blk2 = World.getBlk(x, y-1, z)
        blk3 = World.getBlk(x, y-2, z)
        if blk2 == 42 then
            if blk == 12 then
                World.setBlk(x, y, z, 0)
                Entity.spawnDrop(x, y, z, 20, 1)
            end
        end     
        if blk2 ~= 47 then 
            if blk3 == 47 then
                if blk == 38 then
                World.setBlk(x, y, z, 0)
                World.setBlk(x, y-1, z, 0)
                Entity.spawnDrop(x, y, z, red, 1)
                end
                if blk == 37 then
                    World.setBlk(x, y, z, 0)
                    World.setBlk(x, y-1, z, 0)
                    Entity.spawnDrop(x, y, z, yellow, 1)
                end
                if blk == 44 then
                    if blk2 == 44 then
                        World.setBlk(x, y, z, 0)
                        World.setBlk(x, y-1, z, 0)
                        Entity.spawnDrop(x, y, z, 43, 1)
                    end
                end
            end
        else
            if blk == 5 then
                World.setBlk(x, y, z, 0)
                Entity.spawnDrop(x, y, z, 17, 1)
            end
            if blk == 4 then
                World.setBlk(x, y, z, 0)
                Entity.spawnDrop(x, y, z, 1, 1)
            end
            if blk == 43 then
                World.setBlk(x, y, z, 0)
                Entity.spawnDrop(x, y, z, 45, 1)
            end
            if blk == 1 then
                World.setBlk(x, y, z, 0)
                Entity.spawnDrop(x, y, z, 42, 1)
            end
            if blk == 3 then
                World.setBlk(x, y, z, 0)
                Entity.spawnDrop(x, y, z, 2, 1)
            end
        end
    end
end

function onStart()
    is_moddata = isdir("moddata/crafting")
        if is_moddata then
            print("OKC")
        else
            createDirectory("moddata\\crafting")
        end
    local X = Player.getX()
    local Y = Player.getY()
    local Z = Player.getZ()
    table = file_exists("moddata/crafting/table.txt")
    if table then
        print("table founded")
    else
        Entity.spawnDrop(X, Y, Z, 47, 1)
    end
end
