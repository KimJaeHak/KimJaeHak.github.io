---
title: "WPF Used Examples"
categories:
 - WPF
tags:
 - WPF
 - C#
 - XAML
 - WPF Examples
toc: true
---

# Switching Views With Xaml
## ContentControl - Style 을 활용한 Swithcing View

> MainWindow.xaml

```xml
<ContentControl>
    <ContentControl.Style>
        <Style TargetType="ContentControl">
            <Style.Triggers>
                <DataTrigger Binding="{Binding ViewMode}" Value="Button">
                    <Setter Property="Content">
                        <Setter.Value>
                            <views:ButtonView></views:ButtonView>
                        </Setter.Value>
                    </Setter>
                </DataTrigger>
                <DataTrigger Binding="{Binding ViewMode}" Value="TextBlock">
                    <Setter Property="Content">
                        <Setter.Value>
                            <views:TextBlockView></views:TextBlockView>
                        </Setter.Value>
                    </Setter>
                </DataTrigger>
            </Style.Triggers>
        </Style>
    </ContentControl.Style>
</ContentControl>
```

> ButtonView.xaml

```xml
<UserControl x:Class="Switching_Views.Views.ButtonView"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:Switching_Views.Views"
             mc:Ignorable="d" 
             d:DesignHeight="450" d:DesignWidth="800">
    <Grid>
            <Button Width="200" Height="100">Button View</Button>
    </Grid>
</UserControl>
```

> TextBlockView.xmal

```xml
<UserControl x:Class="Switching_Views.Views.TextBlockView"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:Switching_Views.Views"
             mc:Ignorable="d" 
             d:DesignHeight="450" d:DesignWidth="800">
    <Grid>
          <TextBlock Width="200" Height="100" 
                     TextAlignment="Center" 
                     HorizontalAlignment="Center"
                     VerticalAlignment="Center" Foreground="Aqua">
              Text Block View
          </TextBlock>  
    </Grid>
</UserControl>
```

- MainWindow 에서 Binding 되어 있는 enum 값인 ViewMode(Button|TextBlock) 에 따라서  
보여주는 View 가 달라짐  
- Sytle 의 Trigger 중 Data Trigger 를 활용함