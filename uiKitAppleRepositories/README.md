# uiKitAppleRepositories

##English
###Repositories from apple need to be sorted by stargazersCount, but the github api now only supports sorting by created, updated, pushed, full_name (https://docs.github.com/en/rest/reference/repos). So the solution here is to get all the repositories recursively and then sort them all, which is fine for small datasets (here 150 repositories from Apple), but if there is a lot of data, we need to find another solution.

##German
###Repositories von Apple müssen nach stargazersCount sortiert werden, aber die Github API unterstützt jetzt nur die Sortierung nach created, updated, pushed, full_name (https://docs.github.com/en/rest/reference/repos). Die Lösung hier ist also, alle Repositories rekursiv zu bekommen und sie danach alle noch mal nach stargazersCount zu sortieren, was für kleine Datensätze (hier 150 Repositories von Apple) in Ordnung ist, aber wenn es viele Daten gibt, müssen wir eine andere Lösung finden.
