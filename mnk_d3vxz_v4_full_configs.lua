-- mnk/d3vxz v4 FINAL | Full Configs for All Techs | King + XCZ Flick + Lethal + Loop + Supa + Instant Twisted
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer
local OWNER_PASSWORD = "admin"

pcall(function()
    for _, v in pairs(CoreGui:GetChildren()) do 
        if v.Name == "MNK_D3VXZ_UI" or v.Name == "MNK_AuthUI" then v:Destroy() end 
    end
end)

local function loadMainHub()
    local states = {
        KingTech = false, XCZ = false, LethalDash = false, LoopDash = false, Supa = false, Twisted = false,
        AutoBlock = false, AutoCounter = false, AutoSideDash = false, AntiLag = false, AntiStand = false
    }

    -- ===== COMMON UTILS =====
    local conns = {}
    local function GetCharacterData()
        local char = LocalPlayer.Character
        if not char then return nil,nil,nil end
        return char, char:FindFirstChildOfClass("Humanoid"), char:FindFirstChild("HumanoidRootPart")
    end
    local function FireDashQW()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Communicate") then
            pcall(function() char.Communicate:FireServer(unpack({{Dash=Enum.KeyCode.W, Key=Enum.KeyCode.Q, Goal="KeyPress"}})) end) end
    end
    local function FB(rd)
        local lv = Workspace:FindFirstChild("Live")
        local _,_,root = GetCharacterData()
        if not lv or not root then return nil end
        local mD,bt = rd,nil
        for _,v in ipairs(lv:GetChildren()) do
            if v:IsA("Model") and v~=LocalPlayer.Character then
                local hr,h = v:FindFirstChild("HumanoidRootPart"), v:FindFirstChildOfClass("Humanoid")
                if hr and h and h.Health>0 and (v.Name=="Weakest Dummy" or Players:GetPlayerFromCharacter(v)~=nil) then
                    local d=(hr.Position-root.Position).Magnitude
                    if d<=mD then bt,mD=hr,d end
                end
            end
        end
        return bt
    end
    local function SH(tP,du,rs)
        local _,_,root=GetCharacterData()
        if not tP or not root or du<=0 then return nil end
        local rc,sT,cn=math.clamp(rs,1,10000),tick(),nil
        cn=RunService.RenderStepped:Connect(function(dt)
            if tP and tP.Parent and root and root.Parent then
                local rP=root.Position
                local tPs=Vector3.new(tP.Position.X,rP.Y,tP.Position.Z)
                if (tPs-rP).Magnitude>=0.001 then
                    local gC=CFrame.new(rP,tPs)
                    local a=rc<1000 and math.clamp(1-math.exp(-0.02*rc*dt),0,1) or 1
                    if a>=0.999999 then pcall(function() root.CFrame=gC end)
                    else local lr=root.CFrame:Lerp(gC,a) pcall(function() root.CFrame=CFrame.new(rP)*CFrame.fromMatrix(Vector3.zero, lr.RightVector, lr.UpVector) end) end
                end
                if tick()-sT>=du and cn then cn:Disconnect() end
            elseif cn then cn:Disconnect() end
        end)
        return function() if cn then pcall(function() cn:Disconnect() end) end end
    end

    -- ===== KING TECH TABLE =====
    local KT={a=false,b=false,d=2.9,e=0,f=0.5,g=10,h=150,i=40,j=836,k=46,k1ngJump=0,CharacterTilt=60}
    local O={DA="10503381238",AH=false,AT=false}
    local OLF=nil
    local function k1ngFT()
        local rd=KT.h local lv=Workspace:FindFirstChild("Live") local _,_,root=GetCharacterData() if not lv or not root then return nil end local bt=nil
        for _,v in ipairs(lv:GetChildren()) do if v and v:IsA("Model") and v~=LocalPlayer.Character then local tR=v:FindFirstChild("HumanoidRootPart") local tH=v:FindFirstChild("Head") local tM=v:FindFirstChildOfClass("Humanoid") if tR and tM and tM.Health>0 then local d=(tR.Position-root.Position).Magnitude if d<=rd then if O.AH and tH then bt=tH elseif O.AT and v:FindFirstChild("Torso") then bt=v:FindFirstChild("Torso") or tR else bt=tR end rd=d end end end end return bt
    end
    local function k1ngLT(tg,du,rs)
        local _,hum,root=GetCharacterData() if not (tg and tg.Parent) or not (root and hum) then return nil end
        local rc,sT,cn=math.clamp(rs,1,10000),tick(),nil
        cn=RunService.RenderStepped:Connect(function() if tg and tg.Parent and root and root.Parent then local rP=root.Position local tPs=Vector3.new(tg.Position.X,rP.Y,tP.Position.Z) if (tPs-rP).Magnitude>=0.001 then root.CFrame=CFrame.new(rP,tPs)*CFrame.Angles(math.rad(KT.CharacterTilt),0,0) end if tick()-sT>=du and cn then cn:Disconnect() end else if cn then cn:Disconnect() end end end)
        return function() if cn then pcall(function() cn:Disconnect() end) end end
    end
    local function k1ngTechExecution()
        local _,hum,root=GetCharacterData() if KT.b or not KT.a then return end KT.b=true task.wait(KT.d/10)
        if hum and root then hum.AutoRotate=false if KT.k1ngJump>0 then pcall(function() hum.Jump=true hum:ChangeState(Enum.HumanoidStateType.Jumping) root.AssemblyLinearVelocity=Vector3.new(root.AssemblyLinearVelocity.X,KT.k1ngJump,root.AssemblyLinearVelocity.Z) end) task.wait(0.05) end local tg=k1ngFT() if tg then root.Velocity=Vector3.new(root.Velocity.X,KT.k,root.Velocity.Z) task.wait(KT.e/10) FireDashQW() task.wait(KT.f/10) OLF=k1ngLT(tg,KT.g/10,KT.j) local eT=tick()+(KT.g/10) task.spawn(function() while tick()<eT and KT.a do hum.AutoRotate=false RunService.Heartbeat:Wait() end hum.AutoRotate=true end) else local look=root.CFrame.LookVector root.AssemblyLinearVelocity=look*(KT.k*2) task.wait(KT.e/10) FireDashQW() task.wait(KT.f/10) root.AssemblyLinearVelocity=-look*(KT.k*2) task.wait(KT.g/20) root.AssemblyLinearVelocity=Vector3.zero hum.AutoRotate=true end end task.wait(KT.i/10) KT.b=false
    end

    -- ===== LETHAL =====
    local L={E=false, ID="rbxassetid://12296113986", B=64, Du=0.74, P=0.22, CharacterTilt=60}
    local SLethal={E=false, Delay=0, CharacterTilt=60, JumpBoost=0, AimPart="HumanoidRootPart", Cooldown=4.6, OnCooldown=false}
    local function getLethalTarget()
        local _,_,root=GetCharacterData() if not root then return nil end local closest,shortest=nil,math.huge for _,obj in ipairs(Workspace:GetDescendants()) do if obj:IsA("Model") and obj~=LocalPlayer.Character then local hm=obj:FindFirstChildOfClass("Humanoid") local tHRP=obj:FindFirstChild("HumanoidRootPart") if hm and hm.Health>0 and tHRP then local d=(root.Position-tHRP.Position).Magnitude if d<shortest then shortest=d closest=obj end end end end return closest
    end
    local function aimLethal()
        local _,hum,root=GetCharacterData() if not hum or not root then return end hum.AutoRotate=false local lock=hum:GetPropertyChangedSignal("AutoRotate"):Connect(function() hum.AutoRotate=false end) local target=getLethalTarget() if not target then hum.AutoRotate=true lock:Disconnect() return end local startTime,conn=tick(),nil conn=RunService.RenderStepped:Connect(function() if not L.E then conn:Disconnect() lock:Disconnect() hum.AutoRotate=true return end if tick()-startTime<=L.Du then local tHRP=target:FindFirstChild("HumanoidRootPart") if tHRP then local pred=tHRP.Position+tHRP.AssemblyLinearVelocity*L.P root.CFrame=CFrame.lookAt(root.Position, Vector3.new(pred.X,root.Position.Y,pred.Z))*CFrame.Angles(math.rad(L.CharacterTilt),0,0) end else conn:Disconnect() lock:Disconnect() hum.AutoRotate=true end end)
    end
    local function performSLethalDash(target)
        local _,hum,root=GetCharacterData() if not target or not hum or not root then return end if SLethal.Delay>0 then task.wait(SLethal.Delay) end if SLethal.JumpBoost>0 then pcall(function() root.AssemblyLinearVelocity=Vector3.new(root.AssemblyLinearVelocity.X,SLethal.JumpBoost,root.AssemblyLinearVelocity.Z) end) end local targetPart=target:FindFirstChild(SLethal.AimPart) or target:FindFirstChild("HumanoidRootPart") if not targetPart then return end local origWS,origJP,origPS,origAR=hum.WalkSpeed,hum.JumpPower,hum.PlatformStand,hum.AutoRotate hum.WalkSpeed,hum.JumpPower,hum.PlatformStand,hum.AutoRotate=0,0,true,false root.Velocity,root.RotVelocity=Vector3.zero,Vector3.zero task.wait(0.2) pcall(function() hum:ChangeState(Enum.HumanoidStateType.Physics) end) root.CFrame=root.CFrame*CFrame.Angles(math.rad(SLethal.CharacterTilt),0,0) local teleportDuration,startTime=0.15,tick() local conn conn=RunService.Heartbeat:Connect(function() if tick()-startTime>=teleportDuration then if conn then pcall(function() conn:Disconnect() end) end return end if root and targetPart then root.CFrame=CFrame.new(targetPart.Position-targetPart.CFrame.LookVector*0.3)*CFrame.Angles(math.rad(SLethal.CharacterTilt),0,0) end end) repeat task.wait() until tick()-startTime>=teleportDuration pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end) hum.WalkSpeed,hum.JumpPower,hum.PlatformStand,hum.AutoRotate=origWS,origJP,origPS,origAR root.Velocity,root.RotVelocity=Vector3.zero,Vector3.zero
    end
    local function activateSLethal()
        if not SLethal.E or SLethal.OnCooldown then return end local target=getLethalTarget() if not target then return end local targetHum=target:FindFirstChildOfClass("Humanoid") if not targetHum or targetHum.MaxHealth<=0 or (targetHum.Health/targetHum.MaxHealth<=0.15) then return end SLethal.OnCooldown=true task.spawn(function() performSLethalDash(target) end) task.delay(SLethal.Cooldown,function() SLethal.OnCooldown=false end)
    end

    -- ===== LOOP DASH =====
    local L2={E=false,DM=false,JH=62,D=3,FF=1,Ac=483,Db=false,CharacterTilt=60,AutoCancel=false,CancelAfter=0.5,CancelDuration=0.5,DelayConfig=0}
    local function LR()
        if L2.Db or not L2.E then return end L2.Db=true task.wait(L2.D/10) if not L2.E then L2.Db=false return end if L2.DelayConfig>0 then task.wait(L2.DelayConfig) end local _,h,r=GetCharacterData() if h and r then local oA=h.AutoRotate pcall(function() h.AutoRotate=false h.Jump=true h:ChangeState(Enum.HumanoidStateType.Jumping) end) pcall(function() r.AssemblyLinearVelocity=Vector3.new(r.AssemblyLinearVelocity.X,L2.JH,r.AssemblyLinearVelocity.Z) end) task.wait(0) FireDashQW() task.wait(L2.FF/10) if L2.AutoCancel then task.delay(L2.CancelAfter, function() if r then r.AssemblyLinearVelocity=Vector3.zero r.RotVelocity=Vector3.zero local oldWs=h.WalkSpeed h.WalkSpeed=0 task.wait(L2.CancelDuration) if h then h.WalkSpeed=oldWs end end end) end local tg=FB(50) local cc=tg and SH(tg,1.5,L2.Ac) or nil local eT=tick()+1.2 task.spawn(function() while tick()<eT and L2.E do pcall(function() h.AutoRotate=false end) RunService.Heartbeat:Wait() end pcall(function() h.AutoRotate=oA end) end) task.delay(1.5,function() if cc then pcall(cc) end end) task.delay(1,function() L2.Db=false end) else L2.Db=false end
    end
    local scriptId=math.random(1,1000000) _G.LoopDashId=scriptId local function isCurrent() return _G.LoopDashId==scriptId end
    local LoopDashConfig={Enabled=false, loopReworkAnimDetectId="10503381238", LoopDashDelay=0.28, LoopDashJump=55, LoopDashAccuracy=15, LoopDashCancelDelay=0.4, LoopDashMode="BodyGyro", CancelEnabled=true, CooldownActive=true, NoClipEnabled=true, DashRange=8, JumpMode="Normal", JumpDelay=0.25, DashDuration=1.5, CooldownAnims={["10491993682"]=true,["10479335397"]=true,["13380255751"]=true}}
    local isNoclipping=false local isCooldown=false local isExecuting=false
    local function LoopDashClip() isNoclipping=false local _,hum=GetCharacterData() if hum then hum.AutoRotate=true end end
    local function LoopDashForceCancel() LoopDashClip() local _,_,hrp=GetCharacterData() if hrp then for _,obj in pairs(hrp:GetChildren()) do if obj:IsA("BodyVelocity") or obj:IsA("LinearVelocity") or obj:IsA("BodyAngularVelocity") or obj:IsA("AlignOrientation") or (obj:IsA("Attachment") and obj.Name=="LoopDashAtt") then obj:Destroy() end end hrp.AssemblyLinearVelocity=Vector3.zero end end
    local function LoopDashStartCooldown(d) if not isCurrent() or isCooldown then return end isCooldown=true task.delay(d,function() isCooldown=false end) end
    local function LoopDashGetTorsoTarget()
        local char,_,myRoot=GetCharacterData() if not char or not myRoot then return nil end local params=OverlapParams.new() params.FilterType=Enum.RaycastFilterType.Exclude params.FilterDescendantsInstances={char} local parts=Workspace:GetPartBoundsInRadius(myRoot.Position,LoopDashConfig.DashRange,params) local target,dist=nil,LoopDashConfig.DashRange for _,part in pairs(parts) do local model=part:FindFirstAncestorOfClass("Model") if model and model:FindFirstChildOfClass("Humanoid") and model~=char then local torso=model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso") or model:FindFirstChild("HumanoidRootPart") if torso then local d=(myRoot.Position-torso.Position).Magnitude if d<dist then dist=d target=torso end end end end return target
    end
    local function LoopDashStartRotation(torso)
        local char,hum,root=GetCharacterData() if not root or not hum or not torso or not torso.Parent then isExecuting=false return end local startT=os.clock() local flipped=false local forwardDir=(torso.Position-root.Position).Unit local sideVec=Vector3.new(-forwardDir.Z,0,forwardDir.X) local bav,ao,att0=nil,nil,nil hum.AutoRotate=false
        if LoopDashConfig.LoopDashMode=="BodyGyro" then bav=root:FindFirstChild("LoopDashBAV") or Instance.new("BodyAngularVelocity") bav.Name="LoopDashBAV" bav.MaxTorque=Vector3.new(0,1000000,0) bav.P=15000 bav.AngularVelocity=Vector3.zero bav.Parent=root elseif LoopDashConfig.LoopDashMode=="AlignOrientation" then ao=root:FindFirstChild("LoopDashAO") or Instance.new("AlignOrientation") ao.Name="LoopDashAO" ao.Mode=Enum.OrientationAlignmentMode.OneAttachment ao.MaxTorque=1000000 ao.Responsiveness=100 att0=root:FindFirstChild("LoopDashAtt") or Instance.new("Attachment",root) att0.Name="LoopDashAtt" ao.Attachment0=att0 ao.Parent=root end
        local conn conn=RunService.Heartbeat:Connect(function() if not isCurrent() or not torso or not torso.Parent or not root or not root.Parent then if bav then bav:Destroy() end if ao then ao:Destroy() end if att0 then att0:Destroy() end LoopDashClip() isExecuting=false conn:Disconnect() return end hum.AutoRotate=false local elapsed=os.clock()-startT local torsoPos,rootPos=torso.Position,root.Position
            if LoopDashConfig.LoopDashMode=="BodyGyro" then local angle=(elapsed/0.45)*(math.pi/(LoopDashConfig.DashDuration/1)) local radius=LoopDashConfig.LoopDashAccuracy*(1-math.clamp(elapsed/(LoopDashConfig.DashDuration*0.3),0,1)) local targetLookPos=torsoPos+(sideVec*math.cos(angle)+forwardDir*math.sin(angle))*radius local lookAtCF=CFrame.lookAt(rootPos,Vector3.new(targetLookPos.X,rootPos.Y,targetLookPos.Z)) local relativeCF=root.CFrame:Inverse()*lookAtCF local _,y,_=relativeCF:ToEulerAnglesXYZ() if bav and bav.Parent then bav.AngularVelocity=Vector3.new(0,y*30,0) end elseif LoopDashConfig.LoopDashMode=="AlignOrientation" then local angle=(elapsed/0.45)*(math.pi/(LoopDashConfig.DashDuration/1)) local radius=LoopDashConfig.LoopDashAccuracy*(1-math.clamp(elapsed/(LoopDashConfig.DashDuration*0.3),0,1)) local targetLookPos=torsoPos+(sideVec*math.cos(angle)+forwardDir*math.sin(angle))*radius if ao and ao.Parent then ao.CFrame=CFrame.lookAt(rootPos,Vector3.new(targetLookPos.X,rootPos.Y,targetLookPos.Z)) end else if elapsed>=LoopDashConfig.LoopDashAccuracy and not flipped then root.CFrame=root.CFrame*CFrame.Angles(0,math.pi,0) flipped=true end end
            local distXZ=(Vector2.new(rootPos.X,rootPos.Z)-Vector2.new(torsoPos.X,torsoPos.Z)).Magnitude
            if (LoopDashConfig.CancelEnabled and elapsed>LoopDashConfig.LoopDashCancelDelay and distXZ<2.2) or elapsed>LoopDashConfig.DashDuration or not LoopDashConfig.Enabled then if bav then bav:Destroy() end if ao then ao:Destroy() end if att0 then att0:Destroy() end LoopDashForceCancel() isExecuting=false conn:Disconnect() return end
        end)
    end
    local function LoopDashExecute()
        if not isCurrent() or isExecuting or isCooldown or not LoopDashConfig.Enabled then return end local char,_,root=GetCharacterData() if not root then return end local torso=LoopDashGetTorsoTarget() if not torso then LoopDashClip() return end isExecuting=true local preDashConn preDashConn=RunService.Heartbeat:Connect(function() if not isExecuting or not torso or not torso.Parent or not root or not root.Parent then if preDashConn then preDashConn:Disconnect() end return end local _,hum=GetCharacterData() if hum then hum.AutoRotate=false end root.CFrame=CFrame.lookAt(root.Position,Vector3.new(torso.Position.X,root.Position.Y,torso.Position.Z)) end)
        task.spawn(function()
            if LoopDashConfig.JumpMode=="Normal" then task.wait(math.max(0,LoopDashConfig.LoopDashDelay-0.03)) if not isCurrent() or not torso.Parent or not root.Parent then if preDashConn then preDashConn:Disconnect() end isExecuting=false return end root.AssemblyLinearVelocity=Vector3.new(root.AssemblyLinearVelocity.X,LoopDashConfig.LoopDashJump,root.AssemblyLinearVelocity.Z) isNoclipping=true task.wait(0.03) if preDashConn then preDashConn:Disconnect() end FireDashQW() LoopDashStartRotation(torso) else task.spawn(function() task.wait(LoopDashConfig.JumpDelay) if isCurrent() and LoopDashConfig.Enabled and root.Parent then root.AssemblyLinearVelocity=Vector3.new(root.AssemblyLinearVelocity.X,LoopDashConfig.LoopDashJump,root.AssemblyLinearVelocity.Z) end end) task.wait(LoopDashConfig.LoopDashDelay) if not isCurrent() or not torso.Parent or not root.Parent then if preDashConn then preDashConn:Disconnect() end isExecuting=false return end if preDashConn then preDashConn:Disconnect() end isNoclipping=true FireDashQW() LoopDashStartRotation(torso) end
        end)
    end

    -- ===== SUPA V2 =====
    local SupaCurrentChar=nil local SupaCurrentHum=nil local SupaCurrentRoot=nil local SupaLastTick=0 local SupaCooldown=0.3 local SupaEnabled=false local SupaInCooldown=false
    local function SupaFindClosest()
        if not SupaCurrentRoot then return nil end local closest=nil local smallest=20 for _,desc in pairs(Workspace:GetDescendants()) do if desc:IsA("Model") and desc:FindFirstChild("HumanoidRootPart") and desc~=SupaCurrentChar then local ok,dist=pcall(function() return (SupaCurrentRoot.Position-desc.HumanoidRootPart.Position).Magnitude end) if ok and dist and dist<smallest then closest=desc smallest=dist end end end return closest
    end
    local function SupaSendDash()
        pcall(function() local payload={{Dash=Enum.KeyCode.W, Key=Enum.KeyCode.Q, Goal="KeyPress"}} if SupaCurrentChar and SupaCurrentChar:FindFirstChild("Communicate") then SupaCurrentChar.Communicate:FireServer(unpack(payload)) end end)
        local function findNil(name,class) for _,inst in pairs(getnilinstances()) do if inst.ClassName==class and inst.Name==name then return inst end end return nil end
        pcall(function() local payload={{Goal="delete bv", BV=findNil("moveme","BodyVelocity")}} if SupaCurrentChar and SupaCurrentChar:FindFirstChild("Communicate") then SupaCurrentChar.Communicate:FireServer(unpack(payload)) end end)
    end
    local function SupaPerformStick()
        if not SupaCurrentChar or not SupaCurrentHum or not SupaCurrentRoot then return end
        local targetModel=SupaFindClosest() if not targetModel then return end local targetRoot=targetModel:FindFirstChild("HumanoidRootPart") if not targetRoot then return end
        local saved={} pcall(function() saved.WalkSpeed=SupaCurrentHum.WalkSpeed saved.JumpPower=SupaCurrentHum.JumpPower saved.PlatformStand=SupaCurrentHum.PlatformStand saved.AutoRotate=SupaCurrentHum.AutoRotate end)
        local hb=nil
        do
            pcall(function() SupaCurrentHum.WalkSpeed=0 SupaCurrentHum.JumpPower=0 SupaCurrentHum.PlatformStand=true SupaCurrentHum.AutoRotate=false SupaCurrentRoot.Velocity=Vector3.zero SupaCurrentRoot.RotVelocity=Vector3.zero end)
            for _,d in pairs(SupaCurrentChar:GetDescendants()) do local cn=d.ClassName if cn=="BodyVelocity" or cn=="BodyPosition" or cn=="BodyGyro" or cn=="VectorForce" or cn=="AlignPosition" or cn=="AlignOrientation" or cn=="LinearVelocity" or cn=="AngularVelocity" then pcall(function() d:Destroy() end) end end
            hb=RunService.Heartbeat:Connect(function() if SupaCurrentRoot then pcall(function() SupaCurrentRoot.Velocity=Vector3.zero SupaCurrentRoot.RotVelocity=Vector3.zero end) end if SupaCurrentHum then pcall(function() SupaCurrentHum.WalkSpeed=0 end) end end)
        end
        pcall(SupaSendDash) task.wait(0.2) pcall(function() if SupaCurrentHum then SupaCurrentHum:ChangeState(Enum.HumanoidStateType.Physics) end end) pcall(function() SupaCurrentRoot.CFrame=SupaCurrentRoot.CFrame*CFrame.Angles(math.rad(60),0,0) end)
        local dur=0.2 local start=tick() local follow=RunService.Heartbeat:Connect(function() if dur>tick()-start and SupaCurrentRoot and targetRoot then pcall(function() SupaCurrentRoot.CFrame=CFrame.new(targetRoot.Position-targetRoot.CFrame.LookVector*0.3)*CFrame.Angles(math.rad(60),0,0) end) end end)
        task.wait(dur) if follow then follow:Disconnect() end if hb then hb:Disconnect() end
        pcall(function() SupaCurrentHum:ChangeState(Enum.HumanoidStateType.GettingUp) SupaCurrentHum.WalkSpeed=saved.WalkSpeed or 16 SupaCurrentHum.JumpPower=saved.JumpPower or 50 SupaCurrentHum.PlatformStand=saved.PlatformStand or false SupaCurrentHum.AutoRotate=saved.AutoRotate or true SupaCurrentRoot.Velocity=Vector3.zero SupaCurrentRoot.RotVelocity=Vector3.zero end)
    end
    local function SupaTrigger()
        if not SupaEnabled or SupaInCooldown then return end if SupaCooldown<=tick()-SupaLastTick then SupaLastTick=tick() SupaInCooldown=true task.spawn(function() pcall(SupaPerformStick) end) task.delay(4,function() SupaInCooldown=false end) end
    end

    -- ===== XCZ FLICK LOCKER =====
    local VuxId=math.random(1,1000000) _G.VuxLethalId=VuxId local function VuxIsCurrent() return _G.VuxLethalId==VuxId end
    local VuxConfig={Enabled=false, LethalEnabled=true, LethalAnim="rbxassetid://10503381238", LethalDelay=0.285, LethalJump=55, FlickDelay=0.25, AutoPingComp=true, Smoothness=500, LethalCancelDelay=0.4, CancelEnabled=true, CooldownActive=true, NoClipEnabled=true, DashRange=25, TouchMode=false, Platform="PC", Keybind="E", CooldownAnims={["10491993682"]=true,["10479335397"]=true,["13380255751"]=true}}
    local VuxFlag=false local VuxCooldownFlag=false local VuxExecFlag=false
    local function VuxGetPing() local num=0.05 pcall(function() num=Stats:GetTotalPing()/1000 end) return math.clamp(num,0,0.35) end
    local function VuxFire() local char=LocalPlayer.Character if char then local v5=char:FindFirstChild("Communicate") if v5 then v5:FireServer(unpack({{Dash=Enum.KeyCode.W, Key=Enum.KeyCode.Q, Goal="KeyPress"}})) end end end
    local function VuxClipOff() VuxFlag=false local char=LocalPlayer.Character if char then local hum=char:FindFirstChildOfClass("Humanoid") if hum then hum.AutoRotate=true end end end
    local function VuxForceCancel() VuxClipOff() local char=LocalPlayer.Character local hrp=char and char:FindFirstChild("HumanoidRootPart") if hrp then for _,v in pairs(hrp:GetChildren()) do if v:IsA("BodyVelocity") or v:IsA("LinearVelocity") or v:IsA("Attachment") or v:IsA("BodyAngularVelocity") then v:Destroy() end end hrp.AssemblyLinearVelocity=Vector3.zero end end
    local function VuxGetTarget()
        local char=LocalPlayer.Character if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end local params=OverlapParams.new() params.FilterType=Enum.RaycastFilterType.Exclude params.FilterDescendantsInstances={char} local parts=Workspace:GetPartBoundsInRadius(char.HumanoidRootPart.Position,VuxConfig.DashRange,params) local target=nil local range=VuxConfig.DashRange for _,part in pairs(parts) do local model=part:FindFirstAncestorOfClass("Model") if model and model:FindFirstChildOfClass("Humanoid") and model~=char then local hum=model:FindFirstChildOfClass("Humanoid") local torso=model:FindFirstChild("UpperTorso") or model:FindFirstChild("Torso") or model:FindFirstChild("HumanoidRootPart") if hum and hum.Health>0 and torso then local mag=(char.HumanoidRootPart.Position-torso.Position).Magnitude if mag<range then range=mag target=torso end end end end return target
    end
    local function VuxFlickExecute()
        if not VuxIsCurrent() or VuxExecFlag or VuxCooldownFlag then return end if not VuxConfig.Enabled or not VuxConfig.LethalEnabled then return end
        local char=LocalPlayer.Character local hrp=char and char:FindFirstChild("HumanoidRootPart") local hum=char and char:FindFirstChildOfClass("Humanoid") if not hrp or not hum or hum.Health<=0 then return end local target=VuxGetTarget() if not target then return end VuxExecFlag=true
        local pingDelay=VuxConfig.AutoPingComp and VuxGetPing() or 0
        local startFlick=os.clock() local forwardDir=(target.Position-hrp.Position).Unit local sideVec=Vector3.new(-forwardDir.Z,0,forwardDir.X)
        local bav=nil hum.AutoRotate=false bav=hrp:FindFirstChild("VuxBAV") or Instance.new("BodyAngularVelocity") bav.Name="VuxBAV" bav.MaxTorque=Vector3.new(0,1000000,0) bav.P=15000 bav.AngularVelocity=Vector3.zero bav.Parent=hrp
        local preConn=RunService.Heartbeat:Connect(function() if not VuxExecFlag or not target or not target.Parent or not hrp or not hrp.Parent then if preConn then preConn:Disconnect() end return end hum.AutoRotate=false hrp.CFrame=CFrame.lookAt(hrp.Position,Vector3.new(target.Position.X,hrp.Position.Y,target.Position.Z)) end)
        task.spawn(function()
            task.wait(math.max(0,VuxConfig.LethalDelay-pingDelay-0.03))
            if not VuxIsCurrent() or not target.Parent or not hrp.Parent then if preConn then preConn:Disconnect() end VuxExecFlag=false return end
            hrp.AssemblyLinearVelocity=Vector3.new(hrp.AssemblyLinearVelocity.X,VuxConfig.LethalJump,hrp.AssemblyLinearVelocity.Z) VuxFlag=true task.wait(0.03) if preConn then preConn:Disconnect() end VuxFire()
            local rotConn; rotConn=RunService.Heartbeat:Connect(function()
                if not VuxExecFlag or not target or not target.Parent or not hrp or not hrp.Parent then if bav then bav:Destroy() end VuxClipOff() VuxExecFlag=false if rotConn then rotConn:Disconnect() end return end
                hum.AutoRotate=false
                local elapsed=os.clock()-startFlick
                local angle=(elapsed/0.45)*(math.pi/(1.5/1)) local radius=VuxConfig.Smoothness*0.03*(1-math.clamp(elapsed/0.45,0,1))
                if radius<2 then radius=2 end
                local lookPos=target.Position+(sideVec*math.cos(angle)+forwardDir*math.sin(angle))*radius
                local lookAtCF=CFrame.lookAt(hrp.Position,Vector3.new(lookPos.X,hrp.Position.Y,lookPos.Z))
                local rel=hrp.CFrame:Inverse()*lookAtCF local _,y,_=rel:ToEulerAnglesXYZ() if bav and bav.Parent then bav.AngularVelocity=Vector3.new(0,y*30,0) end
                local distXZ=(Vector2.new(hrp.Position.X,hrp.Position.Z)-Vector2.new(target.Position.X,target.Position.Z)).Magnitude
                if (VuxConfig.CancelEnabled and elapsed>VuxConfig.LethalCancelDelay and distXZ<2.5) or elapsed>1.5 then if bav then bav:Destroy() end VuxForceCancel() VuxExecFlag=false rotConn:Disconnect() if VuxConfig.CooldownActive then VuxCooldownFlag=true task.delay(5,function() VuxCooldownFlag=false end) end return end
            end)
        end)
    end

    -- ===== INSTANT TWISTED =====
    local TwistedConfig={Enabled=false,DashDuration=0.6,Delay=0.22,NoclipEnabled=true,TweenBackDist=6,TweenSpeed=1,NoclipRange=10,AimRange=10,Angle1=0,Angle2=85,Angle3=179,Angle4=70,TwistDelay=0.08}
    local TwistedActiveTween=nil local TwistedNoclipConn=nil
    local function TwistedSetNoclip(state)
        if state and TwistedConfig.NoclipEnabled then
            if TwistedNoclipConn then TwistedNoclipConn:Disconnect() end
            TwistedNoclipConn=RunService.Stepped:Connect(function()
                local char=LocalPlayer.Character if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local root=char.HumanoidRootPart
                local params=OverlapParams.new() params.FilterType=Enum.RaycastFilterType.Exclude params.FilterDescendantsInstances={char}
                local nearbyParts=Workspace:GetPartBoundsInRadius(root.Position,TwistedConfig.NoclipRange,params)
                for _,part in pairs(nearbyParts) do if part:FindFirstAncestorOfClass("Model") and part.Parent:FindFirstChild("Humanoid") then part.CanCollide=false end end
            end)
        else if TwistedNoclipConn then TwistedNoclipConn:Disconnect() TwistedNoclipConn=nil end end
    end
    local function TwistedApply(root,hum)
        local att=Instance.new("Attachment",root) local align=Instance.new("AlignOrientation",root)
        align.Mode=Enum.OrientationAlignmentMode.OneAttachment align.Attachment0=att align.RigidityEnabled=false align.MaxTorque=1000000 align.Responsiveness=60
        local forceOff=RunService.Heartbeat:Connect(function() hum.AutoRotate=false end)
        local function setAngle(angle) align.CFrame=root.CFrame*CFrame.Angles(0,math.rad(angle),0) end
        setAngle(-TwistedConfig.Angle1) task.wait(TwistedConfig.TwistDelay)
        if align and align.Parent then setAngle(TwistedConfig.Angle2) end task.wait(TwistedConfig.TwistDelay)
        if align and align.Parent then setAngle(-TwistedConfig.Angle3) end task.wait(TwistedConfig.TwistDelay)
        if align and align.Parent then setAngle(TwistedConfig.Angle4) end task.wait(TwistedConfig.DashDuration-(TwistedConfig.TwistDelay*3))
        forceOff:Disconnect() align:Destroy() att:Destroy() hum.AutoRotate=true
    end
    local function TwistedGetClosest()
        local targetPos,dist=nil,TwistedConfig.AimRange
        local char=LocalPlayer.Character local root=char and char:FindFirstChild("HumanoidRootPart") if not root then return nil end
        for _,p in pairs(Players:GetPlayers()) do if p~=LocalPlayer and p.Character then local tRoot=p.Character:FindFirstChild("HumanoidRootPart") local tHum=p.Character:FindFirstChild("Humanoid") if tRoot and tHum and tHum.Health>0 then local d=(root.Position-tRoot.Position).Magnitude if d<dist then dist=d local ping=Stats.Network.ServerStatsItem["Data Ping"]:GetValue()/1000 local vel=tRoot.Velocity local predTime=math.clamp(ping,0,0.2) targetPos=tRoot.Position+(Vector3.new(vel.X,0,vel.Z)*predTime) end end end end return targetPos
    end
    local function TwistedExecute()
        local char=LocalPlayer.Character local hum=char and char:WaitForChild("Humanoid") local root=char and char:WaitForChild("HumanoidRootPart") if not hum or not root then return end
        task.spawn(function() if TwistedConfig.TweenBackDist>0 then if TwistedActiveTween then TwistedActiveTween:Cancel() end TwistedActiveTween=TweenService:Create(root,TweenInfo.new(TwistedConfig.TweenSpeed,Enum.EasingStyle.Cubic),{CFrame=root.CFrame*CFrame.new(0,0,TwistedConfig.TweenBackDist)}) TwistedActiveTween:Play() end end)
        task.spawn(function() TwistedSetNoclip(true) task.wait(TwistedConfig.Delay) if TwistedActiveTween then TwistedActiveTween:Cancel() TwistedActiveTween=nil end FireDashQW() TwistedApply(root,hum) task.wait(TwistedConfig.DashDuration) TwistedSetNoclip(false) end)
    end

    -- ===== ANIMATION HOOK =====
    local function handleAnim(track)
        local char,_,root=GetCharacterData() if not (track and track.Animation) then return end local id=tostring(track.Animation.AnimationId or "") local numId=id:match("%d+")
        if KT.a and id:find(O.DA,1,true) then task.spawn(k1ngTechExecution) end
        if L.E and id:find(L.ID,1,true) then task.wait(1.7) if root then root.AssemblyLinearVelocity=Vector3.new(0,L.B,0) end aimLethal() if char and char:FindFirstChild("Communicate") then char.Communicate:FireServer(unpack({{Dash=Enum.KeyCode.W, Key=Enum.KeyCode.Q, Goal="KeyPress"}})) end end
        if SLethal.E then
            if id:find("12296113986",1,true) then task.delay(1.7,function() FireDashQW() activateSLethal() end)
            elseif id:find("95034083206292",1,true) then task.delay(2.55,function() FireDashQW() activateSLethal() end)
            end
        end
        if L2.E and id:find("10503381238",1,true) then if L2.DM then task.delay(1.9,LR) else task.spawn(LR) end end
        if LoopDashConfig.Enabled and numId==tostring(LoopDashConfig.loopReworkAnimDetectId):match("%d+") then LoopDashExecute() end
        if LoopDashConfig.CooldownActive and LoopDashConfig.CooldownAnims[numId] then LoopDashStartCooldown(5) end
        if SupaEnabled and (id:find("10503381238",1,true) or id:find("13379003796",1,true)) then task.delay(0.3,SupaTrigger) end
        if VuxConfig.Enabled and VuxConfig.LethalEnabled then
            if id==VuxConfig.LethalAnim then VuxFlickExecute() end
            if VuxConfig.CooldownActive and VuxConfig.CooldownAnims[numId] then VuxCooldownFlag=true task.delay(5,function() VuxCooldownFlag=false end) end
        end
        if TwistedConfig.Enabled and id:find("13294471966",1,true) then
            local targetPos=TwistedGetClosest()
            if targetPos and root then local hum=char and char:FindFirstChildOfClass("Humanoid") if hum then hum.AutoRotate=false root.CFrame=CFrame.lookAt(root.Position,Vector3.new(targetPos.X,root.Position.Y,targetPos.Z)) end end
            task.spawn(TwistedExecute)
        end
    end

    local function SetupCoreCharacter(c)
        for _,cn in pairs(conns) do pcall(function() cn:Disconnect() end) end conns={}
        local hum=c:WaitForChild("Humanoid") SupaCurrentChar=c SupaCurrentHum=hum SupaCurrentRoot=c:WaitForChild("HumanoidRootPart")
        local ok,c1=pcall(function() return hum.AnimationPlayed:Connect(handleAnim) end) if ok and c1 then table.insert(conns,c1) end
        local am=hum:FindFirstChildOfClass("Animator") if am then local ok2,c2=pcall(function() return am.AnimationPlayed:Connect(handleAnim) end) if ok2 and c2 then table.insert(conns,c2) end end
    end
    LocalPlayer.CharacterAdded:Connect(SetupCoreCharacter)
    if LocalPlayer.Character then SetupCoreCharacter(LocalPlayer.Character) end
    RunService.Stepped:Connect(function()
        if not isCurrent() then return end
        if (LoopDashConfig.NoClipEnabled and isNoclipping) or (VuxConfig.NoClipEnabled and VuxFlag) then
            local c=LocalPlayer.Character if c then for _,p in pairs(c:GetChildren()) do if p:IsA("BasePart") then p.CanCollide=false end end end
        end
    end)

    -- ===== GUI BUILD WITH FULL SETTINGS =====
    local ScreenGui=Instance.new("ScreenGui") ScreenGui.Name="MNK_D3VXZ_UI" ScreenGui.ResetOnSpawn=false ScreenGui.DisplayOrder=2147483647 ScreenGui.IgnoreGuiInset=true local ok=pcall(function() ScreenGui.Parent=CoreGui end) if not ok then ScreenGui.Parent=LocalPlayer:WaitForChild("PlayerGui") end
    local MainFrame=Instance.new("Frame",ScreenGui) MainFrame.Size=UDim2.new(0,520,0,420) MainFrame.Position=UDim2.new(0.5,-260,0.3,-210) MainFrame.BackgroundColor3=Color3.fromRGB(15,12,22) MainFrame.BorderSizePixel=0 MainFrame.Active=true MainFrame.Draggable=true Instance.new("UICorner",MainFrame).CornerRadius=UDim.new(0,10)
    local TopBar=Instance.new("Frame",MainFrame) TopBar.Size=UDim2.new(1,0,0,36) TopBar.BackgroundColor3=Color3.fromRGB(138,43,226) TopBar.BorderSizePixel=0 TopBar.ZIndex=2 Instance.new("UICorner",TopBar).CornerRadius=UDim.new(0,10)
    local HeaderFix=Instance.new("Frame",TopBar) HeaderFix.Size=UDim2.new(1,0,0,8) HeaderFix.Position=UDim2.new(0,0,1,-8) HeaderFix.BackgroundColor3=Color3.fromRGB(138,43,226) HeaderFix.BorderSizePixel=0 HeaderFix.ZIndex=2
    local Title=Instance.new("TextLabel",TopBar) Title.Size=UDim2.new(0.7,0,1,0) Title.Position=UDim2.new(0.04,0,0,0) Title.BackgroundTransparency=1 Title.Text="mnk/d3vxz v4 • All Techs Full Configs" Title.TextColor3=Color3.fromRGB(255,255,255) Title.TextSize=12 Title.Font=Enum.Font.GothamBold Title.TextXAlignment=Enum.TextXAlignment.Left Title.ZIndex=3
    local HideBtn=Instance.new("TextButton",TopBar) HideBtn.Size=UDim2.new(0,26,0,20) HideBtn.Position=UDim2.new(0.78,0,0.5,-10) HideBtn.BackgroundColor3=Color3.fromRGB(110,30,190) HideBtn.Text="-" HideBtn.TextColor3=Color3.fromRGB(255,255,255) HideBtn.TextSize=12 HideBtn.Font=Enum.Font.GothamBold HideBtn.ZIndex=3 Instance.new("UICorner",HideBtn).CornerRadius=UDim.new(0,6)
    local Badge=Instance.new("TextButton",TopBar) Badge.Size=UDim2.new(0,62,0,20) Badge.Position=UDim2.new(0.86,0,0.5,-10) Badge.BackgroundColor3=Color3.fromRGB(170,80,255) Badge.Text="All Techs" Badge.TextColor3=Color3.fromRGB(255,255,255) Badge.TextSize=10 Badge.Font=Enum.Font.GothamBold Badge.ZIndex=3 Instance.new("UICorner",Badge).CornerRadius=UDim.new(0,10)
    local ContainerWrapper=Instance.new("Frame",MainFrame) ContainerWrapper.Size=UDim2.new(1,0,1,-36) ContainerWrapper.Position=UDim2.new(0,0,0,36) ContainerWrapper.BackgroundTransparency=1 ContainerWrapper.ZIndex=2
    local Sidebar=Instance.new("Frame",ContainerWrapper) Sidebar.Size=UDim2.new(0,130,1,0) Sidebar.BackgroundColor3=Color3.fromRGB(20,16,30) Sidebar.BorderSizePixel=0
    local ContentPages={} local tabButtons={}
    local function createContentContainer()
        local c=Instance.new("ScrollingFrame",ContainerWrapper) c.Size=UDim2.new(1,-140,1,-10) c.Position=UDim2.new(0,136,0,5) c.BackgroundTransparency=1 c.CanvasSize=UDim2.new(0,0,0,1200) c.ScrollBarThickness=3 c.Visible=false return c
    end
    ContentPages["Tech"]=createContentContainer() ContentPages["Combat"]=createContentContainer() ContentPages["Anti Lagg"]=createContentContainer() ContentPages["Anti System"]=createContentContainer() ContentPages["Tech"].Visible=true
    local function makeTab(name,y)
        local btn=Instance.new("TextButton",Sidebar) btn.Size=UDim2.new(0.9,0,0,32) btn.Position=UDim2.new(0.05,0,0,y) btn.BackgroundColor3=Color3.fromRGB(30,24,45) btn.Text="    "..name btn.TextColor3=Color3.fromRGB(220,200,255) btn.TextSize=11 btn.Font=Enum.Font.GothamSemibold btn.TextXAlignment=Enum.TextXAlignment.Left Instance.new("UICorner",btn).CornerRadius=UDim.new(0,6) tabButtons[name]=btn
        btn.MouseButton1Click:Connect(function() for tName,page in pairs(ContentPages) do page.Visible=(tName==name) tabButtons[tName].BackgroundColor3=Color3.fromRGB(30,24,45) tabButtons[tName].TextColor3=Color3.fromRGB(220,200,255) end btn.BackgroundColor3=Color3.fromRGB(138,43,226) btn.TextColor3=Color3.fromRGB(255,255,255) end) return btn
    end
    makeTab("Tech",8) makeTab("Combat",45) makeTab("Anti Lagg",82) makeTab("Anti System",119)
    tabButtons["Tech"].BackgroundColor3=Color3.fromRGB(138,43,226) tabButtons["Tech"].TextColor3=Color3.fromRGB(255,255,255)
    local isHidden=false HideBtn.MouseButton1Click:Connect(function() isHidden=not isHidden ContainerWrapper.Visible=not isHidden MainFrame.Size=isHidden and UDim2.new(0,520,0,36) or UDim2.new(0,520,0,420) HideBtn.Text=isHidden and "+" or "-" end)

    local function makeSectionHeader(parent,y,text)
        local lbl=Instance.new("TextLabel",parent) lbl.Size=UDim2.new(0.96,0,0,22) lbl.Position=UDim2.new(0,0,0,y) lbl.BackgroundColor3=Color3.fromRGB(138,43,226) lbl.Text="  "..text lbl.TextColor3=Color3.fromRGB(255,255,255) lbl.TextSize=10 lbl.Font=Enum.Font.GothamBold lbl.TextXAlignment=Enum.TextXAlignment.Left Instance.new("UICorner",lbl).CornerRadius=UDim.new(0,6) return lbl
    end
    local function makeToggle(parent,name,y,key,onChange)
        local Row=Instance.new("Frame",parent) Row.Size=UDim2.new(0.96,0,0,34) Row.Position=UDim2.new(0,0,0,y) Row.BackgroundColor3=Color3.fromRGB(24,19,36) Row.BorderSizePixel=0 Instance.new("UICorner",Row).CornerRadius=UDim.new(0,6)
        local Lbl=Instance.new("TextLabel",Row) Lbl.Size=UDim2.new(0.65,0,1,0) Lbl.Position=UDim2.new(0.06,0,0,0) Lbl.BackgroundTransparency=1 Lbl.Text=name Lbl.TextColor3=Color3.fromRGB(235,220,255) Lbl.TextSize=11 Lbl.Font=Enum.Font.GothamMedium Lbl.TextXAlignment=Enum.TextXAlignment.Left
        local Sw=Instance.new("TextButton",Row) Sw.Size=UDim2.new(0,42,0,22) Sw.Position=UDim2.new(0.72,0,0.5,-11) Sw.BackgroundColor3=states[key] and Color3.fromRGB(138,43,226) or Color3.fromRGB(45,36,66) Sw.Text="" Sw.AutoButtonColor=false Instance.new("UICorner",Sw).CornerRadius=UDim.new(0,11)
        local Knob=Instance.new("Frame",Sw) Knob.Size=UDim2.new(0,16,0,16) Knob.Position=UDim2.new(states[key] and 1 or 0, states[key] and -19 or 3,0.5,-8) Knob.BackgroundColor3=Color3.fromRGB(255,255,255) Knob.BorderSizePixel=0 Instance.new("UICorner",Knob).CornerRadius=UDim.new(1,0)
        Sw.MouseButton1Click:Connect(function() states[key]=not states[key] local s=states[key] Sw.BackgroundColor3=s and Color3.fromRGB(138,43,226) or Color3.fromRGB(45,36,66) Knob:TweenPosition(s and UDim2.new(1,-19,0.5,-8) or UDim2.new(0,3,0.5,-8),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.15,true) if onChange then onChange(s) end end) return Row
    end
    local function makeConfigBox(parent,y,height)
        local box=Instance.new("Frame",parent) box.Size=UDim2.new(0.96,0,0,height) box.Position=UDim2.new(0,0,0,y) box.BackgroundColor3=Color3.fromRGB(19,15,28) box.BorderSizePixel=0 Instance.new("UICorner",box).CornerRadius=UDim.new(0,6) return box
    end
    local function addInputToBox(box,labelText,posX,posY,defaultVal,onChange)
        local lbl=Instance.new("TextLabel",box) lbl.Size=UDim2.new(0.22,0,0,14) lbl.Position=UDim2.new(posX,0,0,posY) lbl.BackgroundTransparency=1 lbl.Text=labelText lbl.TextColor3=Color3.fromRGB(170,150,200) lbl.TextSize=8 lbl.Font=Enum.Font.GothamSemibold
        local tb=Instance.new("TextBox",box) tb.Size=UDim2.new(0.22,0,0,20) tb.Position=UDim2.new(posX,0,0,posY+14) tb.BackgroundColor3=Color3.fromRGB(30,24,45) tb.TextColor3=Color3.fromRGB(255,255,255) tb.Text=tostring(defaultVal) tb.TextSize=9 tb.Font=Enum.Font.GothamMedium Instance.new("UICorner",tb).CornerRadius=UDim.new(0,4)
        tb.FocusLost:Connect(function() if onChange then onChange(tb.Text) end end) return tb
    end

    local curY=6
    -- KING TECH SECTION
    makeSectionHeader(ContentPages["Tech"],curY,"KING TECH ENGINE") curY=curY+26
    makeToggle(ContentPages["Tech"],"Enable King Tech",curY,"KingTech",function(v) KT.a=v if not v and OLF then pcall(function() OLF() end) OLF=nil local _,hum=GetCharacterData() if hum then hum.AutoRotate=true end end end) curY=curY+38
    do
        local box=makeConfigBox(ContentPages["Tech"],curY,88) curY=curY+92
        addInputToBox(box,"Anim ID",0.02,2,O.DA,function(t) if t~="" then O.DA=t end end)
        addInputToBox(box,"Jump Boost",0.26,2,KT.k1ngJump,function(t) KT.k1ngJump=tonumber(t) or 0 end)
        addInputToBox(box,"Act Delay",0.50,2,KT.d,function(t) KT.d=tonumber(t) or 2.9 end)
        addInputToBox(box,"Dash Delay",0.74,2,KT.e,function(t) KT.e=tonumber(t) or 0 end)
        addInputToBox(box,"Aim Delay",0.02,40,KT.f,function(t) KT.f=tonumber(t) or 0.5 end)
        addInputToBox(box,"Lock Length",0.26,40,KT.g,function(t) KT.g=tonumber(t) or 10 end)
        addInputToBox(box,"Radius",0.50,40,KT.h,function(t) KT.h=tonumber(t) or 150 end)
        addInputToBox(box,"Velocity",0.74,40,KT.k,function(t) KT.k=tonumber(t) or 46 end)
    end

    -- XCZ FLICK
    makeSectionHeader(ContentPages["Tech"],curY,"XCZ - FLICK LOCKER [VUX]") curY=curY+26
    makeToggle(ContentPages["Tech"],"Enable XCZ Flick",curY,"XCZ",function(v) VuxConfig.Enabled=v VuxConfig.LethalEnabled=v end) curY=curY+38
    do
        local box=makeConfigBox(ContentPages["Tech"],curY,88) curY=curY+92
        addInputToBox(box,"Lethal Delay",0.02,2,VuxConfig.LethalDelay,function(t) VuxConfig.LethalDelay=tonumber(t) or 0.285 end)
        addInputToBox(box,"Flick Delay",0.26,2,VuxConfig.FlickDelay,function(t) VuxConfig.FlickDelay=tonumber(t) or 0.25 end)
        addInputToBox(box,"Jump",0.50,2,VuxConfig.LethalJump,function(t) VuxConfig.LethalJump=tonumber(t) or 55 end)
        addInputToBox(box,"Smoothness",0.74,2,VuxConfig.Smoothness,function(t) VuxConfig.Smoothness=tonumber(t) or 500 end)
        addInputToBox(box,"Cancel Delay",0.02,40,VuxConfig.LethalCancelDelay,function(t) VuxConfig.LethalCancelDelay=tonumber(t) or 0.4 end)
        addInputToBox(box,"Dash Range",0.26,40,VuxConfig.DashRange,function(t) VuxConfig.DashRange=tonumber(t) or 25 end)
        addInputToBox(box,"Ping Comp",0.50,40,VuxConfig.AutoPingComp and "ON" or "OFF",function(t) VuxConfig.AutoPingComp=t:lower()=="on" end)
        addInputToBox(box,"Cooldown",0.74,40,VuxConfig.CooldownActive and "ON" or "OFF",function(t) VuxConfig.CooldownActive=t:lower()=="on" end)
    end

    -- LETHAL DASH (FULL)
    makeSectionHeader(ContentPages["Tech"],curY,"LETHAL DASH + SLETHAL [INSTANT]") curY=curY+26
    makeToggle(ContentPages["Tech"],"Enable Lethal Dash",curY,"LethalDash",function(v) L.E=v SLethal.E=v end) curY=curY+38
    do
        local box=makeConfigBox(ContentPages["Tech"],curY,88) curY=curY+92
        addInputToBox(box,"Anim ID",0.02,2,L.ID,function(t) if t~="" then L.ID=t end end)
        addInputToBox(box,"Jump Height",0.26,2,L.B,function(t) L.B=tonumber(t) or 64 end)
        addInputToBox(box,"Duration",0.50,2,L.Du,function(t) L.Du=tonumber(t) or 0.74 end)
        addInputToBox(box,"Prediction",0.74,2,L.P,function(t) L.P=tonumber(t) or 0.22 end)
        addInputToBox(box,"Char Tilt",0.02,40,L.CharacterTilt,function(t) L.CharacterTilt=tonumber(t) or 60 end)
        addInputToBox(box,"SLethal Delay",0.26,40,SLethal.Delay,function(t) SLethal.Delay=tonumber(t) or 0 end)
        addInputToBox(box,"SLethal Jump",0.50,40,SLethal.JumpBoost,function(t) SLethal.JumpBoost=tonumber(t) or 0 end)
        addInputToBox(box,"SLethal Cooldown",0.74,40,SLethal.Cooldown,function(t) SLethal.Cooldown=tonumber(t) or 4.6 end)
    end

    -- LOOP DASH
    makeSectionHeader(ContentPages["Tech"],curY,"LOOP DASH [REWORK]") curY=curY+26
    makeToggle(ContentPages["Tech"],"Enable Loop Dash",curY,"LoopDash",function(v) L2.E=v LoopDashConfig.Enabled=v end) curY=curY+38
    do
        local box=makeConfigBox(ContentPages["Tech"],curY,132) curY=curY+136
        addInputToBox(box,"Dash Range",0.02,2,LoopDashConfig.DashRange,function(t) LoopDashConfig.DashRange=tonumber(t) or 8 end)
        addInputToBox(box,"Loop Delay",0.26,2,LoopDashConfig.LoopDashDelay,function(t) LoopDashConfig.LoopDashDelay=tonumber(t) or 0.28 end)
        addInputToBox(box,"Jump Power",0.50,2,LoopDashConfig.LoopDashJump,function(t) LoopDashConfig.LoopDashJump=tonumber(t) or 55 end)
        addInputToBox(box,"Accuracy",0.74,2,LoopDashConfig.LoopDashAccuracy,function(t) LoopDashConfig.LoopDashAccuracy=tonumber(t) or 15 end)
        addInputToBox(box,"Cancel Delay",0.02,40,LoopDashConfig.LoopDashCancelDelay,function(t) LoopDashConfig.LoopDashCancelDelay=tonumber(t) or 0.4 end)
        addInputToBox(box,"Dash Duration",0.26,40,LoopDashConfig.DashDuration,function(t) LoopDashConfig.DashDuration=tonumber(t) or 1.5 end)
        addInputToBox(box,"Jump Height",0.50,40,L2.JH,function(t) L2.JH=tonumber(t) or 62 end)
        addInputToBox(box,"Aim Acc",0.74,40,L2.Ac,function(t) L2.Ac=tonumber(t) or 483 end)
        addInputToBox(box,"Rot Mode",0.02,78,LoopDashConfig.LoopDashMode,function(t) LoopDashConfig.LoopDashMode=t end)
        addInputToBox(box,"Jump Mode",0.26,78,LoopDashConfig.JumpMode,function(t) LoopDashConfig.JumpMode=t end)
        addInputToBox(box,"NoClip",0.50,78,LoopDashConfig.NoClipEnabled and "ON" or "OFF",function(t) LoopDashConfig.NoClipEnabled=t:lower()=="on" end)
        addInputToBox(box,"Down Mode",0.74,78,L2.DM and "ON" or "OFF",function(t) L2.DM=t:lower()=="on" end)
    end

    -- SUPA
    makeSectionHeader(ContentPages["Tech"],curY,"SUPA [MERE BENNIE V2]") curY=curY+26
    makeToggle(ContentPages["Tech"],"Enable Supa",curY,"Supa",function(v) SupaEnabled=v end) curY=curY+38
    do
        local box=makeConfigBox(ContentPages["Tech"],curY,44) curY=curY+48
        addInputToBox(box,"Range",0.02,2,20,function(t) end)
        addInputToBox(box,"Cooldown",0.26,2,SupaCooldown,function(t) SupaCooldown=tonumber(t) or 0.3 end)
        addInputToBox(box,"Stick Dur",0.50,2,0.2,function(t) end)
        addInputToBox(box,"Tilt",0.74,2,60,function(t) end)
    end

    -- TWISTED INSTANT
    makeSectionHeader(ContentPages["Tech"],curY,"TWISTED [INSTANT]") curY=curY+26
    makeToggle(ContentPages["Tech"],"Enable Instant Twisted",curY,"Twisted",function(v) TwistedConfig.Enabled=v end) curY=curY+38
    do
        local box=makeConfigBox(ContentPages["Tech"],curY,132) curY=curY+136
        addInputToBox(box,"Delay",0.02,2,TwistedConfig.Delay,function(t) TwistedConfig.Delay=tonumber(t) or 0.22 end)
        addInputToBox(box,"Dash Dur",0.26,2,TwistedConfig.DashDuration,function(t) TwistedConfig.DashDuration=tonumber(t) or 0.6 end)
        addInputToBox(box,"Back Dist",0.50,2,TwistedConfig.TweenBackDist,function(t) TwistedConfig.TweenBackDist=tonumber(t) or 6 end)
        addInputToBox(box,"Tween Speed",0.74,2,TwistedConfig.TweenSpeed,function(t) TwistedConfig.TweenSpeed=tonumber(t) or 1 end)
        addInputToBox(box,"Angle R1",0.02,40,TwistedConfig.Angle1,function(t) TwistedConfig.Angle1=tonumber(t) or 0 end)
        addInputToBox(box,"Angle L1",0.26,40,TwistedConfig.Angle2,function(t) TwistedConfig.Angle2=tonumber(t) or 85 end)
        addInputToBox(box,"Angle R2",0.50,40,TwistedConfig.Angle3,function(t) TwistedConfig.Angle3=tonumber(t) or 179 end)
        addInputToBox(box,"Angle L2",0.74,40,TwistedConfig.Angle4,function(t) TwistedConfig.Angle4=tonumber(t) or 70 end)
        addInputToBox(box,"Twist Spd",0.02,78,TwistedConfig.TwistDelay,function(t) TwistedConfig.TwistDelay=tonumber(t) or 0.08 end)
        addInputToBox(box,"Aim Range",0.26,78,TwistedConfig.AimRange,function(t) TwistedConfig.AimRange=tonumber(t) or 10 end)
        addInputToBox(box,"Noclip Range",0.50,78,TwistedConfig.NoclipRange,function(t) TwistedConfig.NoclipRange=tonumber(t) or 10 end)
        addInputToBox(box,"Noclip",0.74,78,TwistedConfig.NoclipEnabled and "ON" or "OFF",function(t) TwistedConfig.NoclipEnabled=t:lower()=="on" end)
    end

    ContentPages["Tech"].CanvasSize=UDim2.new(0,0,0,curY+20)

    makeToggle(ContentPages["Combat"],"Auto Block",6,"AutoBlock",function() end)
    makeToggle(ContentPages["Combat"],"Auto Counter",46,"AutoCounter",function() end)
    makeToggle(ContentPages["Combat"],"Auto Side Dash",86,"AutoSideDash",function() end)
    makeToggle(ContentPages["Anti Lagg"],"Anti Lag",6,"AntiLag",function() end)
    makeToggle(ContentPages["Anti System"],"Anti Stand",6,"AntiStand",function() end)

    RunService.Heartbeat:Connect(function()
        local char=LocalPlayer.Character if not char then return end local humanoid=char:FindFirstChildOfClass("Humanoid")
        if states.AntiLag then pcall(function() settings().Rendering.QualityLevel=Enum.QualityLevel.Level01 Lighting.GlobalShadows=false Lighting.FogEnd=9e9 for _,v in pairs(Workspace:GetDescendants()) do if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Sparkles") then v.Enabled=false end end end) end
        if states.AntiStand and humanoid then pcall(function() if humanoid.PlatformStand then humanoid.PlatformStand=false end end) end
    end)
    task.spawn(function() while true do task.wait(1) local active=0 for _,v in pairs(states) do if v then active+=1 end end Badge.Text=active.." Active" end end)
end

local AuthGui=Instance.new("ScreenGui") AuthGui.Name="MNK_AuthUI" AuthGui.ResetOnSpawn=false AuthGui.DisplayOrder=2147483647 AuthGui.IgnoreGuiInset=true local authSuccess=pcall(function() AuthGui.Parent=CoreGui end) if not authSuccess then AuthGui.Parent=LocalPlayer:WaitForChild("PlayerGui") end
local AuthFrame=Instance.new("Frame",AuthGui) AuthFrame.Size=UDim2.new(0,320,0,170) AuthFrame.Position=UDim2.new(0.5,-160,0.4,-85) AuthFrame.BackgroundColor3=Color3.fromRGB(15,12,22) AuthFrame.BorderSizePixel=0 AuthFrame.Active=true AuthFrame.Draggable=true Instance.new("UICorner",AuthFrame).CornerRadius=UDim.new(0,12)
local AuthHeader=Instance.new("Frame",AuthFrame) AuthHeader.Size=UDim2.new(1,0,0,48) AuthHeader.BackgroundColor3=Color3.fromRGB(138,43,226) AuthHeader.BorderSizePixel=0 Instance.new("UICorner",AuthHeader).CornerRadius=UDim.new(0,12)
local AuthHeaderFix=Instance.new("Frame",AuthHeader) AuthHeaderFix.Size=UDim2.new(1,0,0,12) AuthHeaderFix.Position=UDim2.new(0,0,1,-12) AuthHeaderFix.BackgroundColor3=Color3.fromRGB(138,43,226) AuthHeaderFix.BorderSizePixel=0
local AuthTitle=Instance.new("TextLabel",AuthHeader) AuthTitle.Size=UDim2.new(1,0,1,0) AuthTitle.BackgroundTransparency=1 AuthTitle.Text="mnk/d3vxz v4 • Full Configs" AuthTitle.TextColor3=Color3.fromRGB(255,255,255) AuthTitle.TextSize=12 AuthTitle.Font=Enum.Font.GothamBold
local KeyBox=Instance.new("TextBox",AuthFrame) KeyBox.Size=UDim2.new(0.9,0,0,40) KeyBox.Position=UDim2.new(0.05,0,0,62) KeyBox.BackgroundColor3=Color3.fromRGB(24,19,36) KeyBox.TextColor3=Color3.fromRGB(255,255,255) KeyBox.PlaceholderText="Enter password ('admin')..." KeyBox.PlaceholderColor3=Color3.fromRGB(160,140,200) KeyBox.TextSize=11 KeyBox.Font=Enum.Font.GothamMedium Instance.new("UICorner",KeyBox).CornerRadius=UDim.new(0,8)
local VerifyBtn=Instance.new("TextButton",AuthFrame) VerifyBtn.Size=UDim2.new(0.9,0,0,40) VerifyBtn.Position=UDim2.new(0.05,0,0,114) VerifyBtn.BackgroundColor3=Color3.fromRGB(138,43,226) VerifyBtn.TextColor3=Color3.fromRGB(255,255,255) VerifyBtn.Text="Access Hub" VerifyBtn.TextSize=12 VerifyBtn.Font=Enum.Font.GothamBold Instance.new("UICorner",VerifyBtn).CornerRadius=UDim.new(0,8)
VerifyBtn.MouseButton1Click:Connect(function() if KeyBox.Text:lower()==OWNER_PASSWORD:lower() then AuthGui:Destroy() loadMainHub() else KeyBox.Text="" KeyBox.PlaceholderText="Access Denied! Use 'admin'" end end)
