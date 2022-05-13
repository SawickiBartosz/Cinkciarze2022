# Wymagania do całego projektu
* Dwuosobowy, obejmującystworzenie systemu, w którym:
    + dane z wielu źródeł są umieszczanie w modelu hurtowni danych
    + przygotowana jest wizualizacja danych z wykorzystaniem platformy/platform Business Intelligence
* Idea projektu oraz wykorzystywanych źródeł danych może pochodzić od zespołu i/lub prowadzącego zajęcia
* Projekt powinien wskazywać jasny cel biznesowy (predykcja, badania rynku, analiza problemów) oraz planowane korzyści z punktu widzenia odbiorcy rozwiązania
* Projekt musi posiadać oddzielne warstwy dla przetwarzania ETL (np. SSIS), hurtowni danych (np. MS SQL Server lub Oracle) oraz raportowania (np. Oracle Business IntelligencelubSAS Visual Analytics)
* Projekt musi obejmować integrację danych pochodzących z co najmniej dwóch źródeł, zbiory danych mogą pochodzić z zasobów internetowych lub zostać wygenerowane sztucznie
* Opracowanie koncepcji projektu i wstępnej architektury rozwiązania
* Analiza źródeł danych pod kątem dostępności, harmonogramu odświeżania, niezbędnych transformacji podziału danych
* Projektowanie modelu hurtowni danych uwzględniającego tabele faktowe(dedykowane typy), wymiary i ich zmienność, hierarchie, miary, agregaty, itp.
* Implementacja modelu hurtowni danych
* Przygotowanie mechanizmu pozyskiwania i przetwarzania danych procesami ETL
* Implementacja warstwy raportowej (repozytorium, metadane, modelowanie warstw)
* Zbudowanie finalnych raportów biznesowych
* Dokumentacja systemu i testy funkcjonalności

# Wymagania do KM1
Wymagane elementy dokumentacji:
* Opis celu projektu oraz planowane korzyści z perspektywy odbiorcy rozwiązania
* Diagram oraz opis proponowanej architektury rozwiązania
* Opis wykorzystywanych zbiorów danych wraz z określeniem dostępu, formatu danych i częstotliwości odświeżania
* Opis planowanego procesu ETL ze szczególnym uwzlędnieniem sposobu transformacji i integracji danych
* Model fizyczny hurtowni danych przygotowany w dowolnym narzędziu do projektowania (uwzględniajacy tabele, kolumny, typy danych, wymagalność i relacje)
* Opis kluczowych miar i atrybutów w modelu
* Opis planowanych raportów dla użytkowników
* *Opcjonalne, ale polecane* Wskazanie planowanych testów dla poszczególnych komponentów architektury