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
- [Xaml 에서 Object 생성](#xaml-에서-object-생성)
  - [Elements and Attributes](#elements-and-attributes)
  - [Set Property 와 Content Syntax](#set-property-와-content-syntax)
  - [Collection Syntax](#collection-syntax)
  - [User Control](#user-control)

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
<StackPanel>
  <StackPanel.Children>
    <TextBlock/>
    <Button/>
  </StackPanel.Children>
</StackPanel>
```

## User Control
- 간단한 User Control 예제

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
      <TextBlock Text="Version 1.0" FontSize="16"
                 Foreground="#333333" VerticalAlignment="Bottom" Margin="10 0 0 22"/>
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
      <ColumnDefinition Width="Auto"/>
    </Grid.ColumnDefinitions>

    <!-- Customer list -->
    <Grid x:Name="customerListGrid"
          Background="#777">
      <Grid.RowDefinitions>
        <RowDefinition Height="Auto"/>
        <RowDefinition/>
      </Grid.RowDefinitions>
      <StackPanel Orientation="Horizontal">
        <Button Margin="10" Width="75">
          <StackPanel Orientation="Horizontal">
            <Image Source="/Images/add.png" Height="18" Margin="0 0 5 0"/>
            <TextBlock Text="Add"/>
          </StackPanel>
        </Button>
        <Button Content="Delete" Width="75" Margin="0 10 10 10" />
        <Button Margin="0 10 10 10" Click="ButtonMoveNavigation_Click">
          <Image Source="/Images/move.png" Height="18"/>
        </Button>
      </StackPanel>
      <ListView Grid.Row="1" Margin="10 0 10 10">
        <ListViewItem>Julia</ListViewItem>
        <ListViewItem>Alex</ListViewItem>
        <ListViewItem>Thomas</ListViewItem>
      </ListView>
    </Grid>

    <!-- Customer detail -->
    <StackPanel Grid.Column="1" Margin="10">
      <Label>Firstname:</Label>
      <TextBox/>
      <Label>Lastname:</Label>
      <TextBox/>
      <CheckBox Margin="0 10 0 0">
        Is developer
      </CheckBox>
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
      <RowDefinition/>
      <RowDefinition Height="Auto"/>
    </Grid.RowDefinitions>

    <Menu FontSize="20">
      <MenuItem Header="_View">
        <MenuItem Header="_Customers"/>
        <MenuItem Header="_Products"/>
      </MenuItem>
    </Menu>

    <controls:HeaderControl Grid.Row="1"/>

    <view:CustomersView Grid.Row="2"/>

    <StatusBar Grid.Row="3">
      <StatusBarItem FontSize="20" Content=" (c) Wired Brain Coffee"/>
    </StatusBar>
  </Grid>
</Window>

```

