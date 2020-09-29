#include auto_oculus_touch.ahk

; This is used to adjust the starting default center point for the axis
pitchoffset :=20
yawoffset :=0
rolloffset :=0

; sensitivity
pitchSens := 3
rollSens := 3
yawSens := 5

; Start the Oculus sdk.
InitOculus()
InitvJoy(1)

; Main polling loop.
Loop {
; Grab the latest Oculus input state (Touch, Remote and Xbox One).
Poll()

; Get the various analog values. Triggers are 0.0-1.0, thumbsticks are -1.0-1.0
leftIndexTrigger := GetTrigger(LeftHand, IndexTrigger)
leftHandTrigger := GetTrigger(LeftHand, HandTrigger)
leftX := GetThumbStick(LeftHand, XAxis)
leftY := GetThumbstick(LeftHand, YAxis)
rightIndexTrigger := GetTrigger(RightHand, IndexTrigger)
rightHandTrigger := GetTrigger(RightHand, HandTrigger)
rightX := GetThumbStick(RightHand, XAxis)
rightY := GetThumbStick(RightHand, YAxis)

; Get button states.
; Down is the current state. If you test with this, you get a key every poll it is down. Repeating.
; Pressed is set if transitioned to down in the last poll. Non repeating.
; Released is set if transitioned to up in the last poll. Non repeating.
down := GetButtonsDown()
pressed := GetButtonsPressed()
released := GetButtonsReleased()
touchDown := GetTouchDown()
touchPressed := GetTouchPressed()
touchReleased := GetTouchReleased()

; Modifier Conditions=
Mod1 :=  leftHandTrigger > 0.7 
Mod2 :=  leftIndexTrigger > 0.7
ModAll := Mod1 OR Mod2
ModBoth := Mod1 AND Mod2


;No Modifiers

if NOT ModAll 
{
if pressed & ovrX
SetvJoyButton(1,1)
if released & ovrX
SetvJoyButton(1,0)
if pressed & ovrY
SetvJoyButton(2,1)
if released & ovrY 
SetvJoyButton(2,0)

if pressed & ovrLThumb
SetvJoyButton(4,1)
if released & ovrLThumb
SetvJoyButton(4,0)

if leftX < -0.7
        SetvJoyButton(5,1)
	else
        SetvJoyButton(5,0)

if leftX > .7
        SetvJoyButton(6,1)
	else
        SetvJoyButton(6,0)

if leftY < -0.7
        SetvJoyButton(7,1)
	else
        SetvJoyButton(7,0)

if leftY > .7
        SetvJoyButton(8,1)
	else
        SetvJoyButton(8,0)
}

;modifier 1
if Mod1 AND NOT Mod2

{

if down & ovrX
{
leftPitchX :=GetPitch(leftHand)
leftYawX :=GetYaw(lefthand)
leftRollX :=GetRoll(leftHand)
}

if down & ovrY
{
leftPitchY :=GetPitch(leftHand)
leftYawY :=GetYaw(lefthand)
leftRollY :=GetRoll(leftHand)

}


if leftX < -0.7
        SetvJoyButton(17,1)
	else
        SetvJoyButton(17,0)

if leftX > .7
        SetvJoyButton(18,1)
	else
        SetvJoyButton(18,0)

if leftY < -0.7
        SetvJoyButton(19,1)
	else
        SetvJoyButton(19,0)

if leftY > .7
        SetvJoyButton(20,1)
	else
        SetvJoyButton(20,0)

}


if Mod2 AND NOT Mod1
{
if pressed & ovrX
SetvJoyButton(15,1)
if released & ovrX
SetvJoyButton(15,0)
if pressed & ovrY
SetvJoyButton(16,1)
if released & ovrY 
SetvJoyButton(16,0)

if GetPitch(leftHand) < -30
        SetvJoyButton(11,1)
	else
        SetvJoyButton(11,0)

if GetPitch(leftHand) > 30
        SetvJoyButton(12,1)
	else
        SetvJoyButton(12,0)

if GetYaw(lefthand) < -30
        SetvJoyButton(13,1)
	else
        SetvJoyButton(13,0)

if GetYaw(lefthand) > 30
        SetvJoyButton(14,1)
	else
        SetvJoyButton(14,0)
}
else
{
SetvJoyButton(11,0)
SetvJoyButton(12,0)
SetvJoyButton(13,0)
SetvJoyButton(14,0)
}

;modifier combined

if ModBoth
{
if down & ovrX
{
pitchoffset :=GetPitch(LeftHand)
;yawoffset :=GetYaw(Lefthand)
ResetFacing(LeftHand)
rolloffset :=GetRoll(LeftHand)
}

}

SetvJoyAxis(HID_USAGE_X, (leftRollX - rolloffset)/(180/rollSens))
SetvJoyAxis(HID_USAGE_Y, (leftPitchX - pitchoffset)/(90/pitchSens))
SetvJoyAxis(HID_USAGE_Z, (leftYawX - yawoffset)/(180/yawSens))
SetvJoyAxis(HID_USAGE_RX, (leftRollY - rolloffset)/(180/rollSens))
SetvJoyAxis(HID_USAGE_RY, (leftPitchY - pitchoffset)/(90/pitchSens))
SetvJoyAxis(HID_USAGE_RZ, (leftYawY - yawoffset)/(180/yawSens))

;SetvJoyAxis(HID_USAGE_X, (leftYaw)/40.0)


Sleep, 10
}