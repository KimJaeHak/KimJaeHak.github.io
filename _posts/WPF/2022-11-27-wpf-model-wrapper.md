---
title: "WPF Model wrapper"
categories:
 - WPF
 - MVVM
 - WPF Model wrapper
tags:
 - WPF
 - C#
 - XAML
 - MVVM
toc: true
---

# Notifying , Model Changes
## Model -> ModelWrapper를 위한 Base Class 정의

> Observable : INotifyChange를 구현

```cs
public class Observable : INotifyPropertyChanged
{
    public event PropertyChangedEventHandler PropertyChanged;

    protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }
}
```

> Model Wrapper with Generic

```cs
public class ModelWrapper<T> : Observable
{
    public ModelWrapper(T model)
    {
        if (model == null)
        {
            throw new ArgumentNullException("model");
        }
        Model = model;
    }

    public T Model { get; private set; }

    protected TValue GetValue<TValue>([CallerMemberName] string propertyName = null)
    {
        var propertyInfo = Model.GetType().GetProperty(propertyName);
        return (TValue)propertyInfo.GetValue(Model);
    }

    protected void SetValue<TValue>(TValue value,
        [CallerMemberName] string propertyName = null)
    {
        var propertyInfo = Model.GetType().GetProperty(propertyName);
        var currentValue = propertyInfo.GetValue(Model);
        if (!Equals(currentValue, value))
        {
            propertyInfo.SetValue(Model, value);
            OnPropertyChanged(propertyName);
        }
    }

    protected void RegisterCollection<TWrapper, TModel>(
        ObservableCollection<TWrapper> wrapperCollection,
        List<TModel> modelCollection) where TWrapper : ModelWrapper<TModel>
    {
        wrapperCollection.CollectionChanged += (s, e) =>
        {
        if (e.OldItems != null)
        {
            foreach (var item in e.OldItems.Cast<TWrapper>())
            {
                modelCollection.Remove(item.Model);
            }
        }
        if (e.NewItems != null)
        {
            foreach (var item in e.NewItems.Cast<TWrapper>())
            {
                modelCollection.Add(item.Model);
            }
        }
        };
    }
}
```

## Simple Model Data -> ModelWrapper로 구현 한 예시
### [Simple Example] Simple Model Data -> ModelWrapper

```cs
// Address -> Model Data
public class Address
{
    public int Id { get; set; }

    public string City { get; set; }

    public string Street { get; set; }

    public string StreetNumber { get; set; }
}


// AddressWrapper class
public class AddressWrapper : ModelWrapper<Address>
{
    public AddressWrapper(Address model) : base(model)
    {
    }

    public int Id
    {
        get { return GetValue<int>(); }
        set { SetValue(value); }
    }

    public string City
    {
        get { return GetValue<string>(); }
        set { SetValue(value); }
    }

    public string Street
    {
        get { return GetValue<string>(); }
        set { SetValue(value); }
    }

    public string StreetNumber
    {
        get { return GetValue<string>(); }
        set { SetValue(value); }
    }
}
```