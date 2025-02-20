#Использовать logos

Перем Лог;

#Область ПрограммныйИнтерфейс

#Область Проверки

Процедура ВыполнитьПроверки(ВыбраннаяПроверка = "") Экспорт

	Конфигурация = Новый Конфигурация();
	Конфигурация.Инициализировать();
	
	Монитор = Новый Монитор(Конфигурация);
	
	Если ЗначениеЗаполнено(ВыбраннаяПроверка) Тогда
		Монитор.УстановитьПроверку(ВыбраннаяПроверка);
	КонецЕсли;

	Монитор.ЗапуститьМониторинг();
	Монитор.ОтправитьУведомления();

КонецПроцедуры

Функция ДоступныеПроверки() Экспорт

	Проверки = Новый Соответствие();
	Проверки.Вставить("ПроверкаДисков", ПроверкаДисков);
	Проверки.Вставить("ПроверкаПамяти", ПроверкаПамяти);
	Проверки.Вставить("ПроверкаПроцессора", ПроверкаПроцессора);

	Возврат Проверки; 

КонецФункции

Функция ДанныеСистемы(ТекстЗапроса) Экспорт

	WMI = Новый COMОбъект("WbemScripting.SWbemLocator");
    Сервис = WMI.ConnectServer(".", "root\cimv2");
    Результат = Сервис.ExecQuery(ТекстЗапроса);
    
	Возврат Результат;

КонецФункции

#КонецОбласти

#Область Логирование

Функция Лог() Экспорт

	Если Лог = Неопределено Тогда
		
		Лог = Логирование.ПолучитьЛог(ПараметрыПриложения.ИмяПриложения());
		Лог.УстановитьРаскладку(ЭтотОбъект);

		ВыводЛогаВКонсоль = Новый ВыводЛогаВКонсоль;
		Лог.ДобавитьСпособВывода(ВыводЛогаВКонсоль);

	КонецЕсли;
	
	Возврат Лог;

КонецФункции

Процедура ДобавитьВыводЛогаВФайл(ФайлЛога) Экспорт

	Лог = Лог();

	ВыводЛогаВФайл = Новый ВыводЛогаВФайл;
	ВыводЛогаВФайл.ОткрытьФайл(ФайлЛога, , Ложь);

	Лог.ДобавитьСпособВывода(ВыводЛогаВФайл);

КонецПроцедуры

#КонецОбласти

#Область РезультатМониторинга

Функция ОшибкиМониторинга(ПутьФайла) Экспорт

	Лог = Лог();

	Если Не РаботаСФайлами.Существует(ПутьФайла) Тогда
		Лог.Отладка("Не найден файл для получения ошибок мониторинга");
		Возврат Новый Массив;
	КонецЕсли;
	
	Ошибки = Новый Массив;
	Читатель = Новый ЧтениеТекста(ПутьФайла);
	
	Пока Истина Цикл
		
		СтрокаЛога = Читатель.ПрочитатьСтроку();
		Если СтрокаЛога = Неопределено Тогда
			Прервать;
		КонецЕсли;
		
		Если Найти(СтрокаЛога, "ОШИБКА") > 0 Тогда
			Ошибки.Добавить(СтрокаЛога);
		КонецЕсли;
		
	КонецЦикла;
	
	Читатель.Закрыть();
	
	Возврат Ошибки;

КонецФункции

Функция ТекстУведомления(Ошибки) Экспорт
	
	Тема = СтрШаблон("<b>Количество ошибок: %1</b>", Ошибки.Количество());
	Тело = СтрШаблон("<pre>%1</pre>", СтрСоединить(Ошибки, Символы.ПС + Символы.ПС));
	
	Возврат Тема + Символы.ПС + Тело;
	
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Функция ПолучитьФорматированноеСообщение(Знач СобытиеЛога) Экспорт
   
	Уровень = УровниЛога.НаименованиеУровня(СобытиеЛога.ПолучитьУровень());

	ФорматированноеСообщение = СтрШаблон("%1: %2 - %3",
		ТекущаяДата(),
		Уровень,
		СобытиеЛога.ПолучитьСообщение());

	Возврат ФорматированноеСообщение;
 
 КонецФункции

#КонецОбласти
