using System;
using System.Threading.Tasks;
using CitizenFX.Core;

namespace csharp_boilerplate_template.Server
{
    public class ServerMain : BaseScript
    {
        public ServerMain()
        {
            Debug.WriteLine("Hi from csharp_boilerplate_template.Server!");
            Tick += OnTick;
        }

        [Command("hello_server")]
        public void HelloServer()
        {
            Debug.WriteLine("Sure, hello.");
        }

        private async Task OnTick()
        {
            int count = 0;
            int sleep = 0;
            Debug.WriteLine("Start Thread with loop");
            while (count < 1200)
            {
                count++;
                Debug.WriteLine($"count: {count} && sleep: {sleep}");
                if (count == 1000)
                {
                    sleep = 2500;
                    Debug.WriteLine("In count == 1000 condition!");
                }

                await Delay(sleep);
            }
            Debug.WriteLine("End of this thread");
        }
    }
}