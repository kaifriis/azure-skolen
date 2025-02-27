using System;
using Xunit;
using Xunit.Abstractions;

namespace AzureWorkshopAppTests
{
    public class ThaUnitTests
    {

                private readonly ITestOutputHelper _output;

        public ThaUnitTests(ITestOutputHelper output)
        {
            _output = output;
        }
        
        [Fact]
        public void TestShouldPass()
        {
            try
            {
                const bool testShouldPass = true;
                _output.WriteLine("Starting test execution...");
                
                Assert.True(testShouldPass);
                
                _output.WriteLine("Test completed successfully");
            }
            catch (Exception ex)
            {
                _output.WriteLine($"Test failed with error: {ex}");
                throw;
            }
        }
    }
}
