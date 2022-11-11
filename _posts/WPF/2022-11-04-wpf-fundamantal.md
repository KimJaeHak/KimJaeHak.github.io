---
title: "WPF Fundamental"
categories:
 - WPF
tags:
 - WPF
 - C#
 - XAML
toc: true
---

# Xaml 에서 Object 생성
## Elements and Attributes

<p align="center">
<img src="/assets/images/auto/2022-11-04-09-52-16.png" onclick="window.open(this.src)" width="45%">
&nbsp; &nbsp; &nbsp; &nbsp;
<img src="/assets/images/auto/2022-11-04-09-52-23.png" onclick="window.open(this.src)" width="45%">
</p>


## Set Property 와 Content Syntax
- Property를 값을 설정 하는 방법은 여러가지가 있는데 아래와 같음.
  1. Attribute로 설정
  2. Property Element 로 설정 
  3. Content로 설정(xaml parser에 의한 자동설정)

<p align="center">
<img src="/assets/images/auto/2022-11-04-10-04-20.png" onclick="window.open(this.src)" width="80%">
</p>

> 3번째 Content로 설정은 어떻게 자동으로 일어 날까?  
> 아래의 설명을 보자.

<p align="center">
<img src="/assets/images/auto/2022-11-04-10-07-52.png" onclick="window.open(this.src)" width="80%">
</p>

- 요약해 보자면, Property Element가 없이 Xaml에 설정됨
-  Xaml Parser가 Control에 설정되어 있는 ContentPropertyAttribute를 찾음 
-  해당 Property에 Mapping

## Collection Syntax

<p align="center">
<img src="/assets/images/auto/2022-11-04-10-12-53.png" onclick="window.open(this.src)" width="80%">
</p>

> StackPanel의 ContentPropertyAttribute는 아래와 같고, 그래서 Content Syntax로 바꿔보면  
> 바로 아래와 같이 간단해 지는 것이다.

```cs
[ContentProperty(Name = "Children")]
public abstract class Panel : FrameworkElement
{
  public UIElementCollection Children { get ... }
  ...
}
```

```xml
<!--Property Element 사용-->
<StackPanel>
  <StackPanel.Children>
    <TextBlock/>
    <Button/>
  </StackPanel.Children>
</StackPanel>

<!--Property Element 사용하지 않음(간결)-->
<StackPanel>
    <TextBlock/>
    <Button/>
</StackPanel>
```

> **위의 두가지 경우 모두 같은 결과를 보여줌**

## User Control
- [Simple Example] User Control

> HeaderControl.xaml  

```xml
<UserControl x:Class="WiredBrainCoffee.CustomersApp.Controls.HeaderControl"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:WiredBrainCoffee.CustomersApp.Controls"
             mc:Ignorable="d" 
             d:DesignHeight="450" d:DesignWidth="800">
  <Grid Background="#F05A28">
    <StackPanel HorizontalAlignment="Center" Orientation="Horizontal">
      <Image Source="/Images/logo.png" Width="100" Margin="5"/>
      <TextBlock Text="Customers App" FontSize="30" 
                 Foreground="White" VerticalAlignment="Center"/>
    </StackPanel>
  </Grid>
</UserControl>
```

>CustomersView.xaml

```xml
<UserControl x:Class="WiredBrainCoffee.CustomersApp.View.CustomersView"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:WiredBrainCoffee.CustomersApp.View"
             mc:Ignorable="d" 
             d:DesignHeight="450" d:DesignWidth="800">
  <Grid>
    <Grid.ColumnDefinitions>
      <ColumnDefinition Width="Auto"/>
      <ColumnDefinition/>
    </Grid.ColumnDefinitions>

    <!-- Customer list -->
    <Grid x:Name="customerListGrid"
          Background="#777">
      <Grid.RowDefinitions>
        <RowDefinition Height="Auto"/>
        <RowDefinition/>
      </Grid.RowDefinitions>
      <StackPanel Orientation="Horizontal">
        <Button Margin="0 10 10 10" Click="ButtonMoveNavigation_Click">
          <Image Source="/Images/move.png" Height="18"/>
        </Button>
      </StackPanel>
    </Grid>

    <!-- Customer detail -->
    <StackPanel Grid.Column="1" Margin="10">
      <Label>Firstname:</Label>
      <TextBox/>
    </StackPanel>
  </Grid>
</UserControl>

```

> MainWindow.xaml

```xml
<Window x:Class="WiredBrainCoffee.CustomersApp.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:controls="clr-namespace:WiredBrainCoffee.CustomersApp.Controls"
        xmlns:view="clr-namespace:WiredBrainCoffee.CustomersApp.View"
        mc:Ignorable="d"
        Title="Customers App" 
        d:DesignWidth="700" d:DesignHeight="600" Height="500" Width="800" FontSize="20">
  <Grid>
    <Grid.RowDefinitions>
      <RowDefinition Height="Auto"/>
      <RowDefinition Height="Auto"/>
    </Grid.RowDefinitions>

    <controls:HeaderControl Grid.Row="1"/>
    <view:CustomersView Grid.Row="2"/>
  </Grid>
</Window>
```

# Data Binding
## Binding Another Element(다른 요소와 바인딩)

- 화면을 디자인 하다 보면 Control끼리 바인딩을 하게 되는데
- 간단하게 ListView와 TextBox 간 Binding 예제를 보자

### [Simple Example] Binding Another Element

```xml
<ListView x:Name="customerListView" Grid.Row="1" Margin="10 0 10 10">
  <ListViewItem>Julia</ListViewItem>
  <ListViewItem>Alex</ListViewItem>
  <ListViewItem>Thomas</ListViewItem>
</ListView>

<TextBox
  Text="{Binding ElementName=customerListView, Path=SelectedItem.Content,
    Mode=TwoWay, UpdateSourceTrigger=PropertyChanged}"/>
```

- Binding 내부에 속성을 설정할 때  " " 를 사용하지 않는다.
- 속성간 구분은 쉼표 , 로 한다.

> Binding Source? 를 설정 하는 방법은 아래 그림과 같은데

<p align="center">
<img src="/assets/images/auto/2022-11-08-00-27-21.png" onclick="window.open(this.src)" width="80%">
</p>

1. ElementName : 바로 위의 코드 처럼 Source Element에서 x:Name을 설정한 후 Target Element에서  
Binding ElementName으로 설정 하는 방법이다.
2. Source 는 StaticResource를 설정해 놓고 사용하는 방법이다.
3. RelativeSource는 상대적인 Element위치를 가지고 설정
4. 가장 중요한 DataContext를 활용한 방법이다.

## DataContext 의 동작
```xml
// Level_2가 Text에 출력된다.
  <Grid DataContext="level_1">
    <StackPanel DataContext="level_2">
      <TextBlock Text="{Binding}"></TextBlock>
    </StackPanel>
  </Grid>

// 바로 위 부모의 DataContext가 없다면 부모를 계속 해서 찾아 올라간다.
//DataContext를 찾을 때 까지
//Level_1 이 Text에 출력된다.
  <Grid DataContext="level_1">
    <StackPanel>
      <TextBlock Text="{Binding}"></TextBlock>
    </StackPanel>
  </Grid>
```
- 기본적으로 모든 Element는 DataContext를 설정 할 수 있다.
- 위 코드를 보면 TextBock의 Text가 Binding을 사용하고 있다.
- TextBlock은 바로위 부모의 DataContext를 찾고, 없으면 부모의 부모 또 없으면 계속 해서 부모로 올라간다.


## DataContext에 ViewModel 를 통한 Binding
### [Simple Example] ViewModel Binding
> 첫번째로 Model Data를 정의 한다.

```cs
public class Customer
{
  public int Id { get; set; }
  public string? FirstName { get; set; }
  public string? LastName { get; set; }
  public bool IsDeveloper { get; set; }
}
```
<br>
> ViewModelBase를 정의한다.  
> PropertyChange에 대한 구현은 공통으로 사용, INotifyChange를 상속받은 ViewModelBase를 만든다.  

```cs
public class ViewModelBase : INotifyPropertyChanged
{
  public event PropertyChangedEventHandler? PropertyChanged;

  protected virtual void RaisePropertyChanged([CallerMemberName] string? propertyName = null)
  {
    PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
  }
}
```
<br>
> Customer를 Wrapping할  CustomerItemViewModel 만든다.

```cs
  public class CustomerItemViewModel : ViewModelBase
  {
    private readonly Customer _model;

    public CustomerItemViewModel(Customer model)
    {
      _model = model;
    }

    public int Id => _model.Id;

    public string? FirstName
    {
      get => _model.FirstName;
      set
      {
        _model.FirstName = value;
        RaisePropertyChanged();
      }
    }

    public string? LastName
    {
      get => _model.LastName;
      set
      {
        _model.LastName = value;
        RaisePropertyChanged();
      }
    }

    public bool IsDeveloper
    {
      get => _model.IsDeveloper;
      set
      {
        _model.IsDeveloper = value;
        RaisePropertyChanged();
      }
    }
  }
```
<br>
>View의 DataContext에 연결할 CustomersViewModel을 만든다.

```cs
//Customer ViewModel
  public class CustomersViewModel : ViewModelBase
  {
    public CustomersViewModel()
    {
       // Customers 데이터를 업데이트 하는 코드가 필요~~
    }

    public ObservableCollection<CustomerItemViewModel> Customers { get; } = new();
  }
```
<br>
> 여기까지 왔다면 ViewModel은 완성이 되었고, View에 Binding 해보자.

**CustomersView.xaml.cs**
```cs
  public partial class CustomersView : UserControl
  {
    private CustomersViewModel _viewModel;

    public CustomersView()
    {
      InitializeComponent();
      _viewModel = new CustomersViewModel();
      DataContext = _viewModel;
    }
  }
```

**View.xaml**

```xml
      <ListView x:Name="customerListView"
                ItemsSource="{Binding Customers}"
                DisplayMemberPath="FirstName"
                Grid.Row="1" Margin="10 0 10 10"/>

      <TextBox Text="{Binding ElementName=customerListView, 
                      Path=SelectedItem.FirstName,
                      Mode=TwoWay, UpdateSourceTrigger=PropertyChanged}"/>
```
## IValueConverter 를 이용한 Data Convert
- ViewModel을 Binding 할 때 논리적인 값을 View에 속성 값으로 변경해 주어야 하는 경우가 발생 한다.
- 이 떄 IValueConverter를 이용 하면 ViewModel의 속성을 View에 속성 타입으로 변경해 줄 수 있다.  

### [Simple Example] IValueConverter
> View Model 정의

```cs

public class ViewModelConv : ViewModelBase
{
    private int _checked = 0;
    public int Checked
    {
        get => _checked;
        set
        {
            _checked = value;
            RaisePropertyChanged(nameof(Checked));
        }
    }
}

public class ViewModelBase : INotifyPropertyChanged
{
    public event PropertyChangedEventHandler PropertyChanged;

    protected virtual void RaisePropertyChanged(string propertyName)
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }
}
```

> ValueConverter 정의

```cs
    public class ValueConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            var inputValue = value == null ? 0 : (int)value;
            return inputValue %2 == 0;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            //TODO Only TwoWay
            throw new NotImplementedException();
        }
    }
```

> View에서 Converter 설정

```xml
<Window x:Class="WpfConverter.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfConverter"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Window.Resources>
        <local:ValueConverter x:Key="ValueConv" />
    </Window.Resources>
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="30"></RowDefinition>
            <RowDefinition Height="*"></RowDefinition>
        </Grid.RowDefinitions>

        <StackPanel Orientation="Horizontal" HorizontalAlignment="Left">
            <CheckBox IsChecked="{Binding Checked, Converter={StaticResource ValueConv}}"></CheckBox>
            <Button Width="100" Click="ButtonBase_OnClick"></Button>
        </StackPanel>
    </Grid>
</Window>
```

- 위 코드는 button Click 이벤트가 없지만 실제 Button_Click 이벤트 에서는  
값을 +1 해주고 있다.
- ValueConter에서 짝수인 경우에 True, 홀수인 경우에 False를 반환해 주고
- CheckBox에 IsChecked에 맵핑 시켜준다.
- 예제를 위한 어거지 변환 이라고 생각하지만 그냥 보자 ㅎㅎ  
<br>
# Command 를 통한 코드(이벤트) 실행
## Command의 이해

> Command 의 구조
<p align="center">
<img src="/assets/images/auto/2022-11-10-11-08-08.png" onclick="window.open(this.src)" width="80%">
</p>

### [Simple Example] Command의 활용
> <p style="color:red">Before Code</p>

- **MainWindow.xaml**

```xml
<Window x:Class="WpfCommand.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfCommand"
        mc:Ignorable="d"
        Title="MainWindow" Height="350" Width="525">
    <Grid>
        <Button Width="200" Height="100" Click="ButtonBase_OnClick">Click</Button>
    </Grid>
</Window>
```

- **MainWindow.xaml.cs**

```cs
public partial class MainWindow
{
    public MainWindow()
    {
        InitializeComponent();
    }

    private void ButtonBase_OnClick(object sender, RoutedEventArgs e)
    {
        MessageBox.Show("Hello World");
    }
}
```
- 위의 예제를 보면 Button Click 이벤트를 통해서 코드 비하인드 파일에 직접 코딩을 했다.
- View와 이벤트가 겹합도가 높다.

> <p style="color:red">After Code(with Command)</p>

```cs

//ViewModel
public class ButtonViewModel
{
    public DelegateCommand ShowMsgBoxCommand { get; }

    public ButtonViewModel()
    {
        ShowMsgBoxCommand = new DelegateCommand(OnButtomClick);
    }
    private void OnButtomClick(object obj)
    {
        MessageBox.Show("Hello World");
    }
}

//Delegate Command
public class DelegateCommand : ICommand
{
    private readonly Action<object> _execute;
    private readonly Func<object, bool> _canExecute;

    public event EventHandler CanExecuteChanged;
    public void Execute(object parameter) => _execute(parameter);
    public bool CanExecute(object parameter) => _canExecute is null || _canExecute(parameter);

    public void RaiseCanExecuteChanged() => CanExecuteChanged?.Invoke(this, EventArgs.Empty);
    public DelegateCommand(Action<object> execute, Func<object,bool> canExecute = null)
    {
        if (execute == null)
            throw new ArgumentException();
        
        _execute = execute;
        _canExecute = canExecute;
    }
    
}
```

```xml
<!-->MainWindow.xaml<-->
<Window x:Class="WpfCommand.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfCommand"
        mc:Ignorable="d"
        Title="MainWindow" Height="350" Width="525">
    <Grid>
        <Button x:Name="Btn" Width="200" Height="100" 
                Command="{Binding ShowMsgBoxCommand}" 
                CommandParameter="{Binding ElementName=Btn}"
                Content="Click"
                >
        </Button>
        
    </Grid>
</Window>
```
<br>
# 재사용 가능한 Resources 
## Xaml Resource

- 모든 Element에는 Resource 속성이 존재 한다.
- ResourceDictionary 라는 데이터 타입으로 정의 되어 있다.
- ResourceDictionay에 Object Key, Object Value를 추가 할 수 있다.

> 아래의 예제처럼 사용할 수 있다.

```xml
<Window x:Class="WPFResource.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WPFResource"
        mc:Ignorable="d"
        Title="MainWindow" Height="350" Width="525">
    <Grid>
        <Grid.Resources>
            <SolidColorBrush x:Key="BtnColor" Color="DeepPink" />
        </Grid.Resources>
        
        <Button Width="200" Height="200" Background="{StaticResource BtnColor}">Color Button</Button>
    </Grid>
</Window>
```
- Resource키를 찾을 때는 상위 부모를 계속 해서 찾아 올라 간다.
- 그렇다면 전체 프로그램 리소스도 정의 할 수 있지 않을까? 물론 할 수 있다.
- xaml에서 최상의 부모는 App.xaml 에 있는 Application Element 이다.

> 최상의 Xaml Element에 Resource정의

```xml
<Application x:Class="WPFResource.App"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:local="clr-namespace:WPFResource"
             StartupUri="MainWindow.xaml">
    <Application.Resources>
         <SolidColorBrush x:Key="TopBrush" Color="OrangeRed"></SolidColorBrush>
    </Application.Resources>
</Application>
```
- 프로그램 전체에서 사용 할 수 있는 Resource를 정의 했다.  
- 당연한 이야기 이지만, Resource의 Value는 Object이기 때문에 모든 객체를 사용 할 수 있다.

## Resource Dictionary
- 특정 폴더에 Resource 관련 데이터를 몰아 놓고 싶은 생각이 든다.
- 그렇다면 Resource Dictionary를 활용 할 수 있다.  

### [Simple Example] Resource Dictionary

> 아래와 같이 Resource전용 폴더를 만든고

<p align="left">
<img src="/assets/images/auto/2022-11-11-11-01-15.png" onclick="window.open(this.src)" width="60%">
</p>

> xaml 에서 아래와 같이 셋팅 하면 된다.

```xml
<!--> BrushResource.xaml <-->
<ResourceDictionary xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
                    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml">
    <SolidColorBrush x:Key="SBrush" Color="IndianRed"></SolidColorBrush>
</ResourceDictionary>

<!--> ConverterResource.xaml <-->
<ResourceDictionary xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
                    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml">
    <BooleanToVisibilityConverter x:Key="BooleanToVisibilityConv" />
</ResourceDictionary>


<!--> App.xaml <-->
<Application x:Class="WPFResource.App"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:local="clr-namespace:WPFResource"
             StartupUri="MainWindow.xaml">
    <Application.Resources>
        <ResourceDictionary>
            <ResourceDictionary.MergedDictionaries>
                <ResourceDictionary Source="/Resources/BrushResource.xaml"></ResourceDictionary>
                <ResourceDictionary Source="/Resources/ConverterResource.xaml"></ResourceDictionary>
            </ResourceDictionary.MergedDictionaries>    
        </ResourceDictionary>
    </Application.Resources>
</Application>
```
<br>
# Data Templates 활용
## ContentControl의 Rendering 동작

<p align="left">
<img src="/assets/images/auto/2022-11-11-11-26-26.png" onclick="window.open(this.src)" width="48%">
<img src="/assets/images/auto/2022-11-11-11-26-32.png" onclick="window.open(this.src)" width="50%">
</p>

- Content Property에 대해서는 위에서 이미 설명을 했다.
- UIElement를 상속받은 객체들은 Rendering이 잘 될것이다.
- UIElement를 상속받지 않은 일반 객체들은 Rendering시에 객체의 ToStirng()을 Rendering 하게 된다.
- 이것은 우리가 원하는 UI 결과가 아닐 수 있다.
- 그래서 DataTemplate를 통해서 Content 에 원하는 Object를 Binding 할 수 있다.
<br>
> **위의 개념은 리스트 계열을 랜더링하는 ItemsControl도 동일한 개념으로 동작한다.**

<p align="left">
<img src="/assets/images/auto/2022-11-11-11-33-02.png" onclick="window.open(this.src)" width="60%">
</p>

### [Simple Example] DataTemplate

```cs
//People ViewModel
public class PeopleViewModel : ViewModelBase
{
    public ObservableCollection<PersonViewModel> Customers { get;}
    public PeopleViewModel()
    {
        Customers = new ObservableCollection<PersonViewModel>()
        {
            new PersonViewModel() { Name = "Kim", Age = 10 },
            new PersonViewModel() { Name = "Kim2", Age = 11 },
            new PersonViewModel() { Name = "Kim3", Age = 12 },
        };
    }
}

//Person ViewModel
public class PersonViewModel : ViewModelBase
{
    private string _name;
    private int _age;
    public string Name
    {
        get => _name;
        set
        {
            _name = value;
            RaisePropertyChanged();
        }
    }
    public int Age
    {
        get => _age;
        set
        {
            _age = value; 
            RaisePropertyChanged();
        }
    }
}

//ViewModel Base
public class ViewModelBase : INotifyPropertyChanged
{
    public event PropertyChangedEventHandler PropertyChanged;
    protected virtual void RaisePropertyChanged([CallerMemberName] string propertyName = null)
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }
}
```

```xml
<Window x:Class="WpfDataTemplate2.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfDataTemplate2"
        mc:Ignorable="d"
        Title="MainWindow" Height="350" Width="525">
    <Grid>
        <Grid.Resources>
            <DataTemplate x:Key="PersonTemplate">
                <StackPanel Orientation="Horizontal">
                    <TextBlock Text="{Binding Name}" FontWeight="Bold" />
                    <Button Content="{Binding Age}" Width="100"  Margin="10 0" />
                </StackPanel>
            </DataTemplate>
        </Grid.Resources>
        <ListView ItemsSource="{Binding Customers}" 
                  ItemTemplate="{StaticResource PersonTemplate}"/>
    </Grid>
</Window>
```
- Grid.Resource에 DataTemplate을 정의해 놓는다.
- Binding된 Item개체는 Person이라는 것을 알 수 있습니다.
- DataTemplate Element에 TextBlock, Button을 정의 하고 Binding 합니다.
- ListView ItemTemplate에 정의된 Resource를 할당 합니다.
