package CHANGEME

import (
	"strings"
	"testing"
)

func Test~(t *testing.T) {
	t.Parallel()

	tests := []struct {
		name     string
		input    string
		expected string
	}{
		{
			name:     "",
			input:    "test",
			expected: "TEST",
		},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			t.Parallel()

			result := strings.ToUpper(test.input)

			if result != test.expected {
				t.Fatalf("expected result to equal '%s', got '%s'", test.expected, result)
			}
		})
	}
}
