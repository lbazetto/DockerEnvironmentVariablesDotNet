using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;

namespace DockerSettingsEnvVariables.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SettingsController : ControllerBase
    {
        private readonly IConfiguration configuration;

        public SettingsController(IConfiguration configuration) {
            this.configuration = configuration;
        }

        [HttpGet]
        public IActionResult Get() 
        {
            var myData = new string[] {
                configuration.GetValue<string>("MyFirstValueCustomConfig"),
                configuration.GetValue<string>("ComplexConfig:0:Parent:Child"),
            };

            return Ok(myData);
        }
            
    }


}