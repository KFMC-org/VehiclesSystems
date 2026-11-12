namespace SmartFoundation.Mvc.Models;

public sealed class VehicleDetailsDrawerViewModel
{
    public string ChassisNumber { get; init; } = "";
    public string PlateDisplay { get; init; } = "بدون لوحة";
    public string RecordStatus { get; init; } = "غير محدد";
    public string RecordStatusTone { get; init; } = "neutral";
    public string CustodyStatus { get; init; } = "بدون عهدة";
    public string CustodyTone { get; init; } = "neutral";

    public List<VehicleDetailsMetricViewModel> Metrics { get; init; } = new();
    public List<VehicleDetailsFieldViewModel> BasicFields { get; init; } = new();
}

public sealed class VehicleDetailsMetricViewModel
{
    public string Title { get; init; } = "";
    public string Value { get; init; } = "";
    public string Icon { get; init; } = "";
    public string Tone { get; init; } = "neutral";
}

public sealed class VehicleDetailsFieldViewModel
{
    public string Label { get; init; } = "";
    public string Value { get; init; } = "—";
    public bool LeftToRight { get; init; }
}
