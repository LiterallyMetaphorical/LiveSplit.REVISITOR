state("Revisitor-Win64-Shipping")
{
    int loading : 0x02ADE260; // 2 MM 3IG 0 Loading
}

init
{
	vars.loading = false;
}   

startup
  {
		if (timer.CurrentTimingMethod == TimingMethod.RealTime)
// Asks user to change to game time if LiveSplit is currently set to Real Time.
    {        
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | REVISITOR",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );
        
        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
}

start
{
    return old.loading == 2 && current.loading == 0; 
}

update
{ 
//    print(current.loading.ToString());  
	vars.loading = current.loading == 0;
}

split
{
    return old.loading == 3 && current.loading == 0;
}

isLoading
{
    return vars.loading;
}