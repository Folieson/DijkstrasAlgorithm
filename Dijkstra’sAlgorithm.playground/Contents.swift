import UIKit

var graph:Dictionary<String,Dictionary<String, Int>> = Dictionary.init()
graph.updateValue(["a":6,"b":2], forKey: "start")

print(graph["start"]!.keys)
print(graph["start"]!["a"]!)
print(graph["start"]!["b"]!)

graph.updateValue(["fin":1], forKey: "a")
graph.updateValue(["a":3,"fin":5], forKey: "b")
graph.updateValue([:], forKey: "fin")

var infinity = Int.max
var costs:Dictionary<String,Int> = Dictionary.init()
costs.updateValue(6, forKey: "a")
costs.updateValue(2, forKey: "b")
costs.updateValue(infinity, forKey: "fin")

var parents:Dictionary<String,String> = Dictionary.init()
parents.updateValue("start", forKey: "a")
parents.updateValue("start", forKey: "b")
parents.updateValue(String(), forKey: "in")

var processed:Array<String> = Array.init()

//найти узел с наименьшей стоимостью
func findLowestCostNode(_ costs:Dictionary<String,Int>) -> String {
    var lowestCost = Int.max
    var lowestCostNode = String()
    //перебрать все узлы
    for node in costs.keys {
        let cost = costs[node]!
        //если это узел с наименьшей стоимостью из уже виденных и он еще не был обработан...
        if cost < lowestCost && !processed.contains(node) {
            //...он назначается новым узлом с наименьшей стоимостью
            lowestCost = cost
            lowestCostNode = node
        }
    }
    return lowestCostNode
}

var node = findLowestCostNode(costs)
//если обработаны все узлы, цикл завершается
while node != String()  {
    let cost = costs[node] ?? 0
    let neighbors = graph[node]
    //перебрать всех соседей текущего узла
    for n in neighbors!.keys {
        let newCost = cost + (neighbors?[n] ?? 0)
        //если к соседу можно быстрее добраться через текущий узел...
        if (costs[n] ?? 0) > newCost {
            //..обновить стоимость для этого узла
            costs[n] = newCost
            //этот узел становится новым родителем для соседа
            parents[n] = node
        }
    }
    //узел отмечается как отработанный
    processed.append(node)
    //найти следующий узел для отработки и повторить цикл
    node = findLowestCostNode(costs)
}
print(parents)
print(costs)
