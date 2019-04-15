
public class Permutar {

    private static int contador = 0;
    private static char[] valoresPrint;
    private static char vetChar[];

    public static void main(String[] args) {

        String entrada = args[0];
        int tamanhoStr = String.valueOf(entrada).length();
        String entradaStr = String.valueOf(entrada);

        vetChar = new char[tamanhoStr];

        for (int i = 0; i < tamanhoStr; i++) {
            vetChar[i] = entradaStr.charAt(i);
        }
        permuta(vetChar);
    }

    public static void permuta(char[] vet) {
        valoresPrint = new char[vet.length];
        permutaImprime(vet, 0);
    }

    public static void permutaImprime(char[] vet, int n) {
        if (n == vet.length && valoresPrint[0] != '0') {
            contador++;
            imprime();
        } else {
            for (int i = 0; i < vet.length; i++) {
                boolean encontrouONumero = false;
                for (int j = 0; j < n; j++) {
                    if (valoresPrint[j] == vet[i]) {
                        encontrouONumero = true;
                    }
                }
                if (!encontrouONumero) {
                    valoresPrint[n] = vet[i];
                    permutaImprime(vet, n + 1);
                }
            }
        }
    }

    private static void imprime() {
        for (int i = 0; i < valoresPrint.length; i++) {
            System.out.print(valoresPrint[i] + " ");
        }
        System.out.println("");
    }
}
