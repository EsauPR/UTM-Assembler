#include <iostream>

using namespace std;

/* funcion hanoi: n = numero de discos, in = inicio, aux = medio, dest = final */
int hanoi(int n, char in, char aux, char dest)
{
    /* si no hay discos retorna 0*/
    if (n == 0) return 0;
    else {
        // se mueven n - 1 discos desde origen a auxiliar (medio)
        // se considera a aux como destino
        hanoi(n - 1, in, dest, aux);
        // imprime movimiento
        cout << "Mover disco " << n << " desde " << in << " a " << dest << endl;
        // se mueven n - 1 discos desde auxiliar a destino
        // se considera a aux como inicio
        hanoi(n - 1, aux, in, dest);
    }
}

int main()
{
    /* I = inicio, A = auxiliar (medio), D = destino */
    hanoi(2, 'I', 'A', 'D');

    //cin.get();
    return 0;
} 
