using System.Data;

namespace SmartFoundation.Mvc.Models
{
    public class VehicleProfileVM
    {
        public DataTable Summary { get; set; } = new();
        public DataTable Documents { get; set; } = new();
        public DataTable Insurance { get; set; } = new();
        public DataTable Maintenance { get; set; } = new();
        public DataTable Violations { get; set; } = new();
    }
}