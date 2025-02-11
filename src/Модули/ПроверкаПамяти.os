#Использовать logos

Перем Лог;

Процедура ВыполнитьПроверку(ПараметрыПроверки) Экспорт
	
	Лог = Мониторинг.Лог();
	Лог.Информация("Начало проверки памяти");
	
	Порог = ПараметрыПроверки["Порог"];
	ДанныеПамяти = Мониторинг.ДанныеСистемы("SELECT * FROM Win32_OperatingSystem");
	
	Для Каждого Элемент Из ДанныеПамяти Цикл
		
		ОбщаяПамять = Элемент.TotalVisibleMemorySize;
		СвободнаяПамять = Элемент.FreePhysicalMemory;
		ИспользованнаяПамять = ОбщаяПамять - СвободнаяПамять;
		ПроцентИспользования = Окр((ИспользованнаяПамять / ОбщаяПамять) * 100, 0);
		
		Если ПроцентИспользования > Порог Тогда
		
			Лог.Ошибка("Использовано памяти %1%%, что превышает порог %2%%.",
			ПроцентИспользования, Порог);
		
		Иначе
			
			Лог.Информация("Использовано памяти %1%%",
				ПроцентИспользования);
		
		КонецЕсли;

	КонецЦикла;
	
	Лог.Информация("Завершение проверки памяти");
	
КонецПроцедуры