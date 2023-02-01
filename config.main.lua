DAXTON = DAXTON or {} local sec = 1000 local min = 60*sec

ESX = exports["es_extended"]:getSharedObject()

DAXTON = {

    ["SetBox"] = {      --# เพิ่มได้ไม่จำกัด

        -- ["ชื่อไอเท่ม"] = ({
        --     Add = ({
        --         ({ Type = ("item"), Name = ("a_gold"), Count = ({ 1,2 }), Percent = (100) }),
        --         ({ Type = ("weapon"), Name = ("WEAPON_BOTTLE"), Count = ({ 1,1 }), Percent = (100) }),
        --         ({ Type = ("money"), Name = ("money"), Count = ({ 1000,2500 }), Percent = (100) }),
        --         ({ Type = ("vehicle"), Name = ("furia"), Plate = ("GTA 555"), Percent = (100) }),
        --     }),
        --     RemoveItem = true;   --# เปิด/ปิด การลบไอเท่ม
        -- }),

        ["a_diamond"] = ({
            Add = ({
                ({ Type = ("item"), Name = ("a_gold"), Count = ({ 1,2 }), Percent = (100) }),
                ({ Type = ("weapon"), Name = ("WEAPON_BOTTLE"), Count = ({ 1,1 }), Percent = (100) }),
                ({ Type = ("money"), Name = ("money"), Count = ({ 1000,2500 }), Percent = (100) }),
                ({ Type = ("vehicle"), Name = ("furia"), Plate = ("GTA 555"), Percent = (100) }),
            }),
            RemoveItem = true;
        }),

    },

    -- Function
    ["UPDATE_VEHICLE"] = function(data) --# เอาไว้สำหรับอัปเดทค่าต่างๆ

        -- exports.nc_inventory:AddItem(data.player, {
        --     name = data.plate:upper(),
        --     type = 'vehicle_key'
        -- })
        -- exports['Bu_Garage']:ADDPLATE(data.player, data.plate:upper())
    
        return false,false;
    end;
};
