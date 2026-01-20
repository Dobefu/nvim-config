package CHANGEME

import (
	"testing"
)

func Test(t *testing.T) {
	t.Parallel()

	tests := []struct {
		name     string
		input    string
		expected string
	}{}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			t.Parallel()

			if test.input != test.expected {
				t.Fatalf("expected %s to equal %s", test.input, test.expected)
			}
		})
	}
}
