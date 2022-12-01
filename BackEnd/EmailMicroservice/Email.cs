public class Email
{
    public string? sender { get; set; }
    public string? recipient { get; set; }
    public string? subject { get; set; }
    public string? content { get; set; }

    public override string ToString()
    {
        return $"{sender}, {recipient}, {subject}, {content}";
    }
}